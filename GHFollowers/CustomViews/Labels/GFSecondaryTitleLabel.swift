//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 13/01/24.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textColor = .secondaryLabel
        lineBreakMode = .byTruncatingTail
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        translatesAutoresizingMaskIntoConstraints = false
    }
}
