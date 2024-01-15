//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 11/01/24.
//

import UIKit

class GFTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius        = 10
        layer.borderWidth         = 2
        layer.borderColor         = UIColor.systemGray4.cgColor
        
        font                      = UIFont.preferredFont(forTextStyle: .title2)
        textColor                 = .label
        tintColor                 = .label
        backgroundColor           = .tertiarySystemBackground
        textAlignment             = .center
        adjustsFontSizeToFitWidth = true
        minimumFontSize           = 12
        autocorrectionType        = .no
        returnKeyType             = .go
        placeholder               = "Enter Github User name"
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
