//
//  GithubSelector.swift
//  Pods
//
//  Created by Ondrej Rafaj on 14/08/2017.
//
//

import Foundation
import Octokit


public final class GithubSelector {
    
    public var localizable: Localizable = Localization()
    
    public var didReceiveAuthToken: ((_ token: String)->())?
    
    var configuration: GithubSelectorConfigurable!
    
    var octoAuth: OAuthConfiguration!
    
    
    // MARK: - Presenting
    
    public func baseViewController() -> UINavigationController {
        let home = HomeViewController()
        let nc = UINavigationController(rootViewController: home)
        
        if configuration == nil {
            configuration = GithubSelectorConfig()
        }
        
        nc.modalTransitionStyle = configuration.modalTransitionStyle
        nc.modalPresentationStyle = configuration.modalPresentationStyle
        
        return nc
    }
    
    public static func present(inViewController viewController: UIViewController, animated: Bool = true, configuration: GithubSelectorConfigurable? = nil) {
        let selector = GithubSelector(configuration: configuration)
        let base = selector.baseViewController()
        
        viewController.present(base, animated: animated, completion: nil)
    }
    
    // MARK: - Handling incoming auth urls
    
    public func handle(openURL: URL) {
        
    }
    
    // MARK: - Initialization
    
    public init(configuration: GithubSelectorConfigurable? = nil) {
        self.configuration = configuration
    }
    
    // MARK: - Private interface
    
}
