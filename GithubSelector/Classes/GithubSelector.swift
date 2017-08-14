//
//  GithubSelector.swift
//  Pods
//
//  Created by Ondrej Rafaj on 14/08/2017.
//
//

import Foundation
import Octokit
import RequestKit


let GithubSelectorLoginChangedNotification = Notification.Name("GithubSelectorLoginChangedNotification")


public final class GithubSelector {
    
    static public let shared = GithubSelector()
    
    public var localizable: Localizable = Localization()
    
    public var didReceiveAuthToken: ((_ token: String)->())?
    
    var configuration: GithubSelectorConfigurable!
    
    var oAuthConfig: OAuthConfiguration! {
            return OAuthConfiguration(token: configuration.clientId, secret: configuration.clientSecret, scopes: ["repo", "read:org"])
    }
    
    
    // MARK: - Presenting
    
    public func baseViewController() -> UINavigationController {
        let home = HomeViewController()
        home.githubSelector = self
        let nc = UINavigationController(rootViewController: home)
        
        if configuration == nil {
            configuration = GithubSelectorConfig()
        }
        
        nc.modalTransitionStyle = configuration.modalTransitionStyle
        nc.modalPresentationStyle = configuration.modalPresentationStyle
        
        return nc
    }
    
    public static func present(inViewController viewController: UIViewController, animated: Bool = true, configuration: GithubSelectorConfigurable? = nil) {
        shared.configuration = configuration
        let base = shared.baseViewController()
        
        viewController.present(base, animated: animated, completion: nil)
    }
    
    // MARK: - Handling incoming auth urls
    
    public func handle(openURL url: URL) {
        guard let token: String = url.absoluteString.components(separatedBy: "code=").last, token.characters.count > 0 else {
            return
        }
        configuration.clientToken = token
        
        NotificationCenter.default.post(name: GithubSelectorLoginChangedNotification, object: nil)
        
        didReceiveAuthToken?(token)
    }
    
    // MARK: - Private interface
    
    init() {
        
    }
    
}
