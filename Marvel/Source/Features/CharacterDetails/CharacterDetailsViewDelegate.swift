//
//  CharacterDetailsViewDelegate.swift
//  Marvel
//
//  Created by Ruan Reis on 08/03/21.
//  Copyright © 2021 Ruan Reis. All rights reserved.
//

import Foundation

protocol CharacterDetailsViewDelegate: AnyObject {
    
    func close()
    
    func loveIt(_ status: Bool)
}
