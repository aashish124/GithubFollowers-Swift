//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 13/01/24.
//

import UIKit
import SafariServices


protocol UserInfoViewControllerDelegate : AnyObject {
    func githubProfileTapped(user : User)
    func getFollowersTapped(user : User)
}

class UserInfoViewController: UIViewController {
    
    var headerView : UIView = UIView()
    var gitTileView1 = UIView()
    var gitTileView2 = UIView()
    var dateLabel = GFBodyLabel(textAlignment: .center)
    
    var username : String!
    weak var delegate : FollowerListViewControllerDelegate!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureViewController()
        configureHeaderView()
        configureGitTileView1()
        configureGitTileView2()
        configureDateLabel()
        getUserDetails()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant : 20),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    
    func configureGitTileView1() {
        view.addSubview(gitTileView1)
        gitTileView1.translatesAutoresizingMaskIntoConstraints = false
        gitTileView1.layer.cornerRadius = 16
        gitTileView1.backgroundColor = .secondarySystemBackground
        
        NSLayoutConstraint.activate([
            gitTileView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            gitTileView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gitTileView1.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            gitTileView1.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    
    func configureGitTileView2() {
        view.addSubview(gitTileView2)
        gitTileView2.translatesAutoresizingMaskIntoConstraints = false
        gitTileView2.layer.cornerRadius = 16
        gitTileView2.backgroundColor = .secondarySystemBackground
        
        NSLayoutConstraint.activate([
            gitTileView2.topAnchor.constraint(equalTo: gitTileView1.bottomAnchor, constant: 20),
            gitTileView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gitTileView2.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            gitTileView2.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    
    func configureDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.text = "Github since Feb 2015"
        
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: gitTileView2.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    

    func getUserDetails() {
        NetworkManager.shared.getUserDetails(userName: username) { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let user) :
                DispatchQueue.main.async {
                    let repoVc = UserInfoGitViewController1(user : user)
                    repoVc.delegate = self
                    
                    let followerVc = UserInfoGitViewController2(user : user)
                    followerVc.delegate = self
                    
                    self.showChildVc(viewController: UserInfoHeaderViewController(user: user), on: self.headerView)
                    self.showChildVc(viewController: repoVc, on: self.gitTileView1)
                    self.showChildVc(viewController: followerVc, on: self.gitTileView2)
                    self.dateLabel.text = "Created Since \(user.createdAt.convertToDisplayFormat())"
                }
            case .failure(let error) :
                self.presentAlertControllerOnMainThread(titleMessage: "Something bad occured.", bodyMessage: error.localizedDescription, actionTitle: "Ok")
            }
        }
    }
    
    
    func showChildVc(viewController : UIViewController, on view : UIView) {
        addChild(viewController)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    // If ever we want to remove middle tile view for a particular case, we can do it this way.
//    func removeTileView1() {
//        gitTileView1.isHidden = true
//        NSLayoutConstraint.activate([
//            gitTileView1.heightAnchor.constraint(equalToConstant: 0)
//        ])
//    }
    
}


extension UserInfoViewController : UserInfoViewControllerDelegate {
    func githubProfileTapped(user : User) {
        let url = URL (string: user.htmlUrl)
        openSafari(with: url)
    }
    
    
    func getFollowersTapped(user : User) {
        delegate.didTapGetFollowers(userName: user.login)
        dismissVC()
    }
}
