//
//  Localizable.swift
//  Pods
//
//  Created by Ondrej Rafaj on 14/08/2017.
//
//

import Foundation


public protocol Localizable {
    
    static func get(_ key: String) -> String
    static func get(_ key: String, _ arguments: CVarArg...) -> String
    
}
