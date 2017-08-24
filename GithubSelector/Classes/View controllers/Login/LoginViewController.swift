//
//  LoginViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 14/08/2017.
//
//

import Foundation
import UIKit
import SnapKit


class LoginViewController: ViewController {
    
    let githubLogo = UIImageView()
    let authButton = UIButton()
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        githubLogo.contentMode = .scaleAspectFit
        githubLogo.tintColor = .darkGray
        githubLogo.image = Icons.logo.withRenderingMode(.alwaysTemplate)
        view.addSubview(githubLogo)
        
        authButton.layer.cornerRadius = 5
        authButton.layer.borderColor = UIColor.darkGray.cgColor
        authButton.layer.borderWidth = 1
        authButton.setTitle(Localization.get("gs.login.oauth-button"), for: .normal)
        authButton.setTitleColor(.darkGray, for: .normal)
        authButton.addTarget(self, action: #selector(authenticate(_:)), for: .touchUpInside)
        view.addSubview(authButton)
        
        githubLogo.snp.makeConstraints { (make) in
            make.width.height.equalTo(42)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(authButton.snp.top).offset(-60)
        }
        
        authButton.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: Actions
    
    func authenticate(_ sender: UIButton) {
        guard let url = githubSelector.oAuthConfig.authenticate() else {
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
        if let _ = notification.object as? String {
            dismiss(animated: true, completion: nil)
        }
    }
    
}
