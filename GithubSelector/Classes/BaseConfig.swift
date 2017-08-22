//
//  BaseConfig.swift
//  Pods
//
//  Created by Ondrej Rafaj on 22/08/2017.
//
//

import Foundation


open class BaseConfig: Configurable {
    
    // MARK: Auth
    
    var _clientId: String?
    
    open var clientId: String {
        get {
            guard let ret = _clientId else {
                fatalError("Subclass this config or set your client ID directly")
            }
            return ret
        }
        set {
            _clientId = newValue
        }
    }
    
    var _clientSecret: String?
    
    open var clientSecret: String {
        get {
            guard let ret = _clientSecret else {
                fatalError("Subclass this config or set your client secret directly")
            }
            return ret
        }
        set {
            _clientSecret = newValue
        }
    }
    
    open var clientToken: String? = nil
    
    // MARK: Presentation
    
    open var modalTransitionStyle: UIModalTransitionStyle = .coverVertical
    
    open var modalPresentationStyle: UIModalPresentationStyle {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return .formSheet
        default:
            return .fullScreen
        }
    }
    
    // MARK: Selectables
    
    open var selectable: AllowSelecting = .anyFile
    
    // MARK: Initialization
    
    public init() {
        
    }
    
    public convenience init(clientId: String, clientSecret: String, clientToken: String? = nil) {
        self.init()
        
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.clientToken = clientToken
    }
    
}
