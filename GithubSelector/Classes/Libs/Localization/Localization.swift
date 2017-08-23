//
//  Localization.swift
//  Pods
//
//  Created by Ondrej Rafaj on 14/08/2017.
//
//

import Foundation


class Localization: Localizable {
    
    static func get(_ key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
    
    static func get(_ key: String, _ arguments: CVarArg...) -> String {
        let format: String = get(key)
        return String(format: format, arguments: arguments)
    }
    
}

