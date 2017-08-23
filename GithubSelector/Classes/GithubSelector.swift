//
//  GithubSelector.swift
//  Pods
//
//  Created by Ondrej Rafaj on 14/08/2017.
//
//

import Foundation
import RequestKit


let GithubSelectorLoginChangedNotification = Notification.Name("GithubSelectorLoginChangedNotification")


public final class GithubSelector {
    
    static public let shared = GithubSelector()
    
    public var localizable: Localizable = Localization()
    
    public var didSelectFile: ((_ file: GithubFile)->())?
    public var didReceiveAuthToken: ((_ token: String)->())?
    public var logout: (()->())?
    
    var configuration: Configurable!
    
    private var _oAuthConfig: OAuthConfiguration?
    var oAuthConfig: OAuthConfiguration! {
        if _oAuthConfig == nil {
            _oAuthConfig = OAuthConfiguration(token: configuration.clientId, secret: configuration.clientSecret, scopes: ["repo", "read:org"])
        }
        return _oAuthConfig
    }
    
    private var _tokenConfig: TokenConfiguration?
    var tokenConfig: TokenConfiguration! {
        get {
            if _tokenConfig == nil {
                guard let token = configuration.clientToken else {
                    return nil
                }
                _tokenConfig = TokenConfiguration(token)
            }
            return _tokenConfig
        }
        set {
            _tokenConfig = newValue
        }
    }
    
    // MARK: - Presenting
    
    public func baseViewController() -> UINavigationController {
        let home = HomeViewController()
        let nc = UINavigationController(rootViewController: home)
        
        if configuration == nil {
            configuration = BaseConfig()
        }
        
        nc.modalTransitionStyle = configuration.modalTransitionStyle
        nc.modalPresentationStyle = configuration.modalPresentationStyle
        
        return nc
    }
    
    public static func present(inViewController viewController: UIViewController, animated: Bool = true, configuration: Configurable? = nil) {
        shared.configuration = configuration
        let base = shared.baseViewController()
        
        viewController.present(base, animated: animated, completion: nil)
    }
    
    // MARK: - Handling incoming auth urls
    
    public func handle(openURL url: URL) {
        oAuthConfig.handleOpenURL(url: url) { config in
            guard let token = config.accessToken else {
                return
            }
            
            self.tokenConfig = config
            self.configuration.clientToken = token
            
            NotificationCenter.default.post(name: GithubSelectorLoginChangedNotification, object: config)
            
            self.didReceiveAuthToken?(token)
        }
    }
    
    // MARK: - Private interface
    
    init() {
        
    }
    
}
