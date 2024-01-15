//
//  GHActionButton.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 11/01/24.
//

import UIKit

class GFActionButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor : UIColor, title : String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius                        = 10
        titleLabel?.textAlignment                 = .center
//        titleLabel?.textColor                     = .white
        setTitleColor(.white, for: .normal)  // Appropriate way of setting the color
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font                          = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    
    func setup(backgroundColor : UIColor, title : String){
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
}
