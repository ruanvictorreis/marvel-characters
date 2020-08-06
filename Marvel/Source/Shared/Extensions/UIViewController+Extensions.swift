//
//  UIViewController+Extensions.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupNavigation(title: String = "", isHidden: Bool = false, isTranslucent: Bool = true,
                         hasLargeTitle: Bool = false) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.prefersLargeTitles = hasLargeTitle
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.setNavigationBarHidden(isHidden, animated: true)
    }
    
    func showMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showLoading() {
        let container = UIView()
        let loadingView = UIView()
        let activityIndicator = UIActivityIndicatorView()
        
        container.tag = 1000
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor = .cloud
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        loadingView.center = self.view.center
        loadingView.backgroundColor = .eclipse
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.color = .white
        activityIndicator.style = UIActivityIndicatorView.Style.large
        
        activityIndicator.center = CGPoint(
            x: loadingView.frame.size.width / 2,
            y: loadingView.frame.size.height / 2
        )
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        self.view.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        let seconds = 0.7
        let delay = seconds * Double(NSEC_PER_SEC)
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            if let viewWithTag = self.view.viewWithTag(1000) {
                viewWithTag.removeFromSuperview()
            }
        })
    }
}
