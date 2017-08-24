//
//  Config.swift
//  GithubSelector
//
//  Created by Ondrej Rafaj on 24/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import GithubSelector


class Config: BaseConfig {
    
    let keychainKey = "github-token"
    
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        guard let fileUrl = Bundle.main.url(forResource: "Secrets", withExtension: "plist"), let data = try? Data(contentsOf: fileUrl) else {
            fatalError("Secrets file not found")
        }
        
        guard let secrets = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: String] else {
            fatalError("Secrets file is not in a correct format")
        }
        guard let clientId = secrets?["clientId"], let clientSecret = secrets?["clientSecret"] else {
            fatalError("Secrets file is missing data")
        }
        
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
    
}
