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
        
        if configuration == nil {
            configuration = BaseConfig()
        }
        home.githubSelector = self
        
        let nc = UINavigationController(rootViewController: home)
        
        nc.navigationBar.barStyle = .blackOpaque
        nc.navigationBar.barTintColor = UIColor(hexTriplet: "24292E")
        nc.navigationBar.tintColor = .white
        
        nc.modalTransitionStyle = configuration.modalTransitionStyle
        nc.modalPresentationStyle = configuration.modalPresentationStyle
        
        return nc
    }
    
    public func present(inViewController viewController: UIViewController, animated: Bool = true) {
        let base = baseViewController()
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
            
            self.didReceiveAuthToken?(token)
            
            NotificationCenter.default.post(name: GithubSelectorLoginChangedNotification, object: token)
        }
    }
    
    // MARK: - Private interface
    
    public init(configuration config: Configurable) {
        configuration = config
    }
    
    public init(configuration config: Configurable, url: URL) {
        configuration = config
        handle(openURL: url)
    }
    
}
