//
//  UIViewController+Extensions.swift
//  Marvel
//
//  Created by Ruan Reis on 29/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    
    func showMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showLoading() {
        let background = UIView()
        let container = UIView()
        let loading = UIActivityIndicatorView()
        
        background.tag = 1000
        background.backgroundColor = .cloud
        
        container.backgroundColor = .eclipse
        container.clipsToBounds = true
        container.layer.cornerRadius = 10
        
        loading.color = .white
        loading.style = .large
        
        view.addSubview(background)
        background.addSubview(container)
        container.addSubview(loading)
        
        background.snp.makeConstraints { make in
            make.width.height.equalTo(view)
        }
        
        container.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(140)
        }
        
        loading.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        loading.startAnimating()
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
