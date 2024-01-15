//
//  UserInfoHeaderViewController.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 13/01/24.
//

import UIKit

class UserInfoHeaderViewController: UIViewController {
    
    var user : User!
    
    var avatarImageView  = GFAvatarImageView(frame: .zero)
    var loginLabel = GFTitleLabel(textAlignment: .left, fontSize: 28)
    var nameLabel = GFSecondaryTitleLabel()
    var locationImageView = UIImageView()
    var locationLabel = GFSecondaryTitleLabel()
    var bioLabel = GFBodyLabel(textAlignment: .left)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configuresubviews()
    }
    
    
    init(user : User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(loginLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    
    func configuresubviews() {
        avatarImageView.downloadImage(from: user.avatarUrl)
        loginLabel.text = user.login
        nameLabel.text  = user.name ?? ""
        locationImageView.image = UIImage(systemName: SFSymbolsName.locationImage.rawValue)
        locationLabel.text = user.location ?? ""
        bioLabel.text = user.bio ?? "No bio"
    }
    
    func layoutUI() {
        locationImageView.tintColor = .secondaryLabel
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.numberOfLines = 3
        
        let padding : CGFloat = 20
        let imageTextPadding : CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            loginLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: imageTextPadding),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            loginLabel.heightAnchor.constraint(equalToConstant: 28),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 2),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: imageTextPadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: imageTextPadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60) // Check this height
        ])
    }
    
}
