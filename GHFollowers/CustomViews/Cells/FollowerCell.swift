//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 12/01/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let identifier = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let loginLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(loginLabel)
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            loginLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            loginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            loginLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    func setUpCell(userName : String, avatarImageUrl : String) {
        loginLabel.text = userName
        avatarImageView.downloadImage(from: avatarImageUrl)
    }
}
