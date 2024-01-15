//
//  UserInfoGitViewController1.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 13/01/24.
//

import UIKit

class UserInfoGitViewController1: UserInfoGitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTile()
        setupActionButton()
    }
    
    func setupTile() {
        userInfoGitView1.setUpTile(tileType: .repos, withCount: user.publicRepos)
        userInfoGitView2.setUpTile(tileType: .gists, withCount: user.publicGists)
    }
    
    func setupActionButton() {
        actionButton.setup(backgroundColor: .purple, title: "Github Profile")
    }
    
    
    override func didTapActionButton() {
        delegate.githubProfileTapped(user : user)
    }

}
