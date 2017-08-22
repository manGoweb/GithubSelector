//
//  Configurable.swift
//  Pods
//
//  Created by Ondrej Rafaj on 14/08/2017.
//
//

import Foundation


public enum AllowSelecting {
    case anyFile
    case fileType(extension: String)
    case fileTypes(extensions: [String])
}


public protocol Configurable {
    
    
    var clientId: String { get }
    var clientSecret: String { get }
    
    var clientToken: String? { get set }
    
    var selectable: AllowSelecting { get }
    
    var modalTransitionStyle: UIModalTransitionStyle { get }
    var modalPresentationStyle: UIModalPresentationStyle { get }
    
}

