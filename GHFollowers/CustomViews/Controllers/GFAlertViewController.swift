//
//  GFAlertViewController.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 12/01/24.
//

import UIKit

class GFAlertViewController: UIViewController {
    
    let contentView: UIView = UIView()
    let alertTitleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let alertBodyLabel = GFBodyLabel(textAlignment: .center)
    let alertActionButton = GFActionButton(backgroundColor: .systemPink, title: "OK")
    
    var alertTitle : String?
    var alertBodyMessage : String?
    var alertActionButtonTitle : String?
    
    init(alertTitleMessage: String, alertBodyMessage: String, alertActionButtonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitleMessage
        self.alertBodyMessage = alertBodyMessage
        self.alertActionButtonTitle = alertActionButtonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContentView()
        configureAlertTitleLabel()
        configureAlertActionButton()
        configureAlertBodyLabel()
        
    }
    
    
    func configureContentView() {
        view.addSubview(contentView)
        
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.white.cgColor
        
        contentView.backgroundColor = .systemBackground
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 280),
            contentView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    
    func configureAlertTitleLabel() {
        contentView.addSubview(alertTitleLabel)
        alertTitleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            alertTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            alertTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            alertTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            alertTitleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureAlertBodyLabel() {
        contentView.addSubview(alertBodyLabel)
        alertBodyLabel.text = alertBodyMessage ?? "Unable to complete request."
        alertBodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            alertBodyLabel.topAnchor.constraint(equalTo: alertTitleLabel.bottomAnchor, constant: 8),
            alertBodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            alertBodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            alertBodyLabel.bottomAnchor.constraint(equalTo: alertActionButton.topAnchor, constant: -12)
        ])
    }
    
    
    func configureAlertActionButton() {
        contentView.addSubview(alertActionButton)
        alertActionButton.setTitle(alertActionButtonTitle ?? "Ok", for: .normal)
        alertActionButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            alertActionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            alertActionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            alertActionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            alertActionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    @objc func dismissAlert() {
        dismiss(animated: true)
        // TODO: Also pop the current viewcontroller on which the alert is present if required. 
    }
}
