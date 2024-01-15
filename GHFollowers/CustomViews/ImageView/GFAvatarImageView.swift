//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 12/01/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder")
    var cacheImageData = NetworkManager.shared.cachedImageData

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(from urlString : String) {
        let cacheKey = NSString(string: urlString)
        if let image = cacheImageData.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        let url = URL(string: urlString)
        guard let url = url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            guard let data = data else { return }
            do{
                let image = UIImage(data: data)
                guard let image = image else { return }
                self.cacheImageData.setObject(image, forKey: cacheKey)
                DispatchQueue.main.async {
                    self.image = image
                }
                return
            }
        }
        task.resume()
    }
}
