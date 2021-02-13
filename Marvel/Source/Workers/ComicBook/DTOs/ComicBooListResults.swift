//
//  ComicBooListResults.swift
//  Marvel
//
//  Created by Ruan Reis on 30/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import Foundation

struct ComicBooListResults: Decodable {
    
    let offset: Int
    
    let limit: Int
    
    let total: Int
    
    let count: Int
    
    let results: [ComicBook]
}
