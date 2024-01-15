//
//  UserInfoGitViewController.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 13/01/24.
//

import UIKit

class UserInfoGitViewController: UIViewController {
    
    let stackView = UIStackView()
    let actionButton = GFActionButton()
    var userInfoGitView1 = UserInfoGitTileView()
    var userInfoGitView2 = UserInfoGitTileView()
    
    var user : User!
    weak var delegate : UserInfoViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureStackView()
        configureActionButton()
    }
    
    
    init(user : User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureViews() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        actionButton.backgroundColor = .purple
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 80),
            
            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    
    func configureStackView() {
        stackView.addArrangedSubview(userInfoGitView1)
        stackView.addArrangedSubview(userInfoGitView2)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
    }
    
    
    func configureActionButton() {
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
    
    
    @objc func didTapActionButton() { }
}
