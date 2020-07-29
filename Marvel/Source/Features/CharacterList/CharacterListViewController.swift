//
//  ViewController.swift
//  Marvel
//
//  Created by Ruan Reis on 28/07/20.
//  Copyright © 2020 Ruan Reis. All rights reserved.
//

import UIKit
import Alamofire

class CharacterListViewController: UIViewController {
    
    @IBOutlet private var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.text = R.Localizable.helloWorld()
        
        let enconding = JSONEncoding.default
        let url = MarvelAPI.build(section: .characters, limit: 25)
        let request = RequestData(url: url, method: .get, encoding: enconding)
        
        Network().request(
            data: request,
            decoder: Decoder(expectation: Character.self),
            success: { response in
                print(response)
            },
            failure: { error in
                print(error)
            })
        
    }
}
