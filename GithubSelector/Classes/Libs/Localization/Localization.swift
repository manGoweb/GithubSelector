//
//  Localization.swift
//  Pods
//
//  Created by Ondrej Rafaj on 14/08/2017.
//
//

import Foundation


class Localization: Localizable {
    
    func get(_ key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
    
}
