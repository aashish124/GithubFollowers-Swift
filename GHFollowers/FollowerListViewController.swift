//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 11/01/24.
//

import UIKit


protocol FollowerListViewControllerDelegate : AnyObject {
    func didTapGetFollowers(userName : String)
}

class FollowerListViewController: UIViewController {
    
    enum Section { case main }
    
    var userName : String!
    var followers  : [Follower] = []
    var filteredFollowers : [Follower] = []
    var page : Int = 1
    var hasMoreFollowers : Bool = true
    var isSearching = false
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var dataSource : UICollectionViewDiffableDataSource<Section,Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(userName: userName, page: page)
        configureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.getThreeColumnCollectionViewLayout(view: self.view))
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        
    }
    
    
    func getFollowers(userName: String, page : Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(userName: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            dismissLoadingView()
            switch result {
            case .success(let followers) :
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                let message = "This user has no followers. Please follow this user.😃"
                if followers.isEmpty {
                    DispatchQueue.main.async { self.showEmptyView(message: message, on: self.view) }
                }
                self.updateData(on: self.followers)
            case .failure(let error) :
                self.presentAlertControllerOnMainThread(titleMessage: "OOPS. Bad stuff happened.", bodyMessage: error.rawValue, actionTitle: "Ok")
            }
        }
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifier, for: indexPath) as! FollowerCell
            cell.setUpCell(userName: itemIdentifier.login, avatarImageUrl: itemIdentifier.avatarUrl)
            return cell
        })
    }
    
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a user name."
        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    @objc func addButtonTapped() {
        print("Add button tapped.")
        showLoadingView()
        NetworkManager.shared.getUserDetails(userName: userName) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                let favouriteFollower = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistanceManager.updateFavourites(with: favouriteFollower, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.presentAlertControllerOnMainThread(titleMessage: "Successful", bodyMessage: "You have successfully favourited this user.", actionTitle: "Hurrah!")
                        return
                    }
                    self.presentAlertControllerOnMainThread(titleMessage: "Somthing went wrong.", bodyMessage: error.rawValue, actionTitle: "Ok")
                }
            case .failure(let error):
                self.presentAlertControllerOnMainThread(titleMessage: "Somthing went wrong.", bodyMessage: error.rawValue, actionTitle: "Ok")
            }
        }
    }
}

extension FollowerListViewController : UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = scrollView.frame.height
        let contentHeight = scrollView.contentSize.height
        let offSetY = scrollView.contentOffset.y            // TODO: Visualise nicely offset.
        
        if offSetY > contentHeight - height  {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(userName : userName, page : page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray: [Follower] = isSearching ? filteredFollowers : followers
        let destinedVC = UserInfoViewController()
        destinedVC.username = activeArray[indexPath.item].login
        destinedVC.delegate = self
        let navVc = UINavigationController(rootViewController: destinedVC)
        self.present(navVc, animated: true)
    }
}

extension FollowerListViewController : UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        guard let searchText = searchText, !searchText.isEmpty else {
//            TODO: Functionality of pressing "X" button on search bar, showing empty screen as of now.
            return
        }
        isSearching = true
        filteredFollowers = followers.filter { follower in
            follower.login.lowercased().contains(searchText.lowercased())
        }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}


extension FollowerListViewController : FollowerListViewControllerDelegate {
    
    func didTapGetFollowers(userName : String) {
        self.userName = userName
        title = userName
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(userName: userName, page: page)
    }
}
