//
//  ViewCodeProtocol.swift
//  Marvel
//
//  Created by Ruan Reis on 02/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import Foundation

protocol ViewCodeProtocol {
    
    func setupSubviews()
    
    func setupConstraints()
    
    func setupComponents()
}

extension ViewCodeProtocol {
    
    func setupUI() {
        setupSubviews()
        setupConstraints()
        setupComponents()
    }
    
    func setupComponents() {}
}
