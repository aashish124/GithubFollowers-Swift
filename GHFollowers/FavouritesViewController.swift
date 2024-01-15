//
//  FavouritesViewController.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 11/01/24.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    let tableView = UITableView()
    var favourites : [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
    }
    
    
    func configureViewController() {
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(FavouritesCell.self, forCellReuseIdentifier: FavouritesCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    
    func getFavourites() {
        PersistanceManager.retreiveFavouritesFromUserDefaults { result in
            switch result{
            case .success(let favourites) :
                if favourites.isEmpty {
                    self.showEmptyView(message: "No favourites? \n Add one on the followers screen.", on: self.view)
                }else {
                    self.favourites = favourites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error) :
                DispatchQueue.main.async {
                    self.presentAlertControllerOnMainThread(titleMessage: "Something bad.", bodyMessage: error.rawValue, actionTitle: "Ok")
                }
            }
        }
    }
    
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesCell.identifier, for: indexPath) as? FavouritesCell else {
            return UITableViewCell()
        }
        cell.set(userName: favourites[indexPath.row].login, avatarUrl: favourites[indexPath.row].avatarUrl)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destinedVc = FollowerListViewController()
        destinedVc.userName = favourites[indexPath.row].login
        destinedVc.title = favourites[indexPath.row].login
        navigationController?.pushViewController(destinedVc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        PersistanceManager.updateFavourites(with: favourites[indexPath.row], actionType: .remove) { error in
            guard let error = error else {
                self.favourites.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentAlertControllerOnMainThread(titleMessage: "Something bad.", bodyMessage: error.rawValue, actionTitle: "Ok")
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    
}
