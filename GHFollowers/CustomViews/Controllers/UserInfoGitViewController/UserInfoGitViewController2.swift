//
//  UserInfoGitViewController2.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 14/01/24.
//

import UIKit

class UserInfoGitViewController2: UserInfoGitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGitInfoTile()
        setupButton()
    }
    
    
    func setupGitInfoTile() {
        userInfoGitView1.setUpTile(tileType: .following, withCount: user.following)
        userInfoGitView2.setUpTile(tileType: .followers, withCount: user.followers)
    }
    
    
    func setupButton() {
        actionButton.setTitle("Get Followers", for: .normal)
    }

    
    override func didTapActionButton() {
        delegate.getFollowersTapped(user : user)
    }
}
