//
//  UIViewController+Extension.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 12/01/24.
//

import UIKit
import SafariServices

fileprivate var contentView : UIView!

extension UIViewController {
    
    func presentAlertControllerOnMainThread(titleMessage : String, bodyMessage : String, actionTitle: String) {
        DispatchQueue.main.async {
            let alertVc = GFAlertViewController(alertTitleMessage: titleMessage, alertBodyMessage: bodyMessage, alertActionButtonTitle: actionTitle)
            alertVc.modalPresentationStyle = .overFullScreen
            alertVc.modalTransitionStyle = .crossDissolve
            self.present(alertVc, animated: true)
        }
    }
    
    
    func showLoadingView() {
        contentView = UIView(frame: self.view.bounds)
        self.view.addSubview(contentView)
        contentView.backgroundColor = .systemBackground
        contentView.alpha = 0
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 0.25) {
            contentView.alpha = 0.8
        }
        
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    
    func openSafari(with url : URL?) {
        guard let url = url else {
            presentAlertControllerOnMainThread(titleMessage: "Wrong URL", bodyMessage: "The entered url isnot a safari url. ", actionTitle: "Ok")
            return
        }
        let safariVc = SFSafariViewController(url: url)
        safariVc.preferredControlTintColor = .systemGreen
        present(safariVc, animated: true)
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            contentView.removeFromSuperview()
            contentView = nil
        }
    }
    
    
    func showEmptyView(message : String, on view : UIView) {
        let emptyView = EmptyView(message: message)
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
        
    }
}
