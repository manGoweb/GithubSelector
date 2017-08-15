//
//  LoginViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 14/08/2017.
//
//

import Foundation
import UIKit
import Octokit
import SnapKit


class LoginViewController: ViewController {
    
    let authButton = UIButton()
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        authButton.layer.cornerRadius = 5
        authButton.layer.borderColor = UIColor.blue.cgColor
        authButton.layer.borderWidth = 1
        authButton.setTitle("login.oauth-button".localized(), for: .normal)
        authButton.setTitleColor(.blue, for: .normal)
        authButton.addTarget(self, action: #selector(authenticate(_:)), for: .touchUpInside)
        view.addSubview(authButton)
        
        authButton.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: Actions
    
    func authenticate(_ sender: UIButton) {
        guard let url = GithubSelector.shared.oAuthConfig.authenticate() else {
            return
        }
        UIApplication.shared.openURL(url)
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginNotificationRecieved(_:)), name: GithubSelectorLoginChangedNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: GithubSelectorLoginChangedNotification, object: nil);
    }
    
    // MARK: Notifications
    
    func loginNotificationRecieved(_ notification: Notification) {
        if GithubSelector.shared.configuration.clientToken != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
}
