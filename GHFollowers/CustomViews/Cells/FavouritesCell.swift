//
//  FavouritesTableViewCell.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 15/01/24.
//

import UIKit

class FavouritesCell: UITableViewCell {
    
    static let identifier = "FavouritesCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let nameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = avatarImageView.placeHolderImage
        nameLabel.text = nil
    }
    
    
    func set(userName: String, avatarUrl : String) {
        avatarImageView.downloadImage(from: avatarUrl)
        nameLabel.text = userName
    }
    
    
    func configure() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        
        self.accessoryType = .disclosureIndicator
        
        let padding : CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
