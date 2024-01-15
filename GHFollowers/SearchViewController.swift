//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 11/01/24.
//

import UIKit

class SearchViewController: UIViewController {

    let logoImageView = UIImageView()
    let userNameTextField = GFTextField()
    let getFollowersButton = GFActionButton(backgroundColor: .systemGreen, title: "Get Followers")
    var isUserNameEntered : Bool {
        return !userNameTextField.text!.isEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureUserNameTextField()
        configureGetFollowersButton()
        createDismissKeyboardGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
//        Solved the problem : When swiping from left, navigationbar was not coming in the followerListVC
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "gh-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureUserNameTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureGetFollowersButton() {
        view.addSubview(getFollowersButton)
        
        NSLayoutConstraint.activate([
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        getFollowersButton.addTarget(self, action: #selector(pushViewController), for: .touchUpInside)
    }
    
    
    @objc func pushViewController() {
        guard isUserNameEntered else {
            presentAlertControllerOnMainThread(titleMessage: "No User Name", bodyMessage: "Please enter a username so that we can find who you want to look to.", actionTitle: "Ok")
            return
        }
        let followerListVC = FollowerListViewController()
        followerListVC.userName = userNameTextField.text
        followerListVC.title = userNameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
}

extension SearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushViewController()
        return true
    }
}
