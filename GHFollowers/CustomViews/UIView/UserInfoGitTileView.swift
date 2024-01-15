//
//  UserInfoGitTileView.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 13/01/24.
//

import UIKit

class UserInfoGitTileView: UIView {

    let imageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 16)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpTile(tileType : TileType, withCount count : Int){
        switch tileType {
        case .repos :
            imageView.image = UIImage(systemName: SFSymbolsName.reposImage.rawValue)
            titleLabel.text = "Public Repo"
        case .gists :
            imageView.image = UIImage(systemName: SFSymbolsName.gistsImage.rawValue)
            titleLabel.text = "Public Gists"
        case .following :
            imageView.image = UIImage(systemName: SFSymbolsName.followingImage.rawValue)
            titleLabel.text = "Following"
        case .followers :
            imageView.image = UIImage(systemName: SFSymbolsName.followersImage.rawValue)
            titleLabel.text = "Followers"
        }
        countLabel.text = String(count)
    }
    
    
    func configure() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(countLabel)
        
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding : CGFloat = 20
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            countLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
