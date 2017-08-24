//
//  ViewController.swift
//  GithubSelector
//
//  Created by Ondrej Rafaj on 08/14/2017.
//  Copyright (c) 2017 Ondrej Rafaj. All rights reserved.
//

import UIKit
import SnapKit
import GithubSelector
import KeychainSwift


class ViewController: UIViewController {
    
    let fileLabel = UILabel()
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GithubSelector!"
        
        view.backgroundColor = .white
        
        // Create button
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Tap me!", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(startSelectingFiles(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
        
        // Create label
        fileLabel.textColor = .black
        fileLabel.textAlignment = .center
        fileLabel.text = "No file has been selected yet ..."
        view.addSubview(fileLabel)
        
        fileLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(button)
            make.bottom.equalTo(button.snp.top).offset(-20)
        }
    }
    
    // MARK: Actions
    
    func startSelectingFiles(_ sender: UIButton) {
        guard let fileUrl = Bundle.main.url(forResource: "Secrets", withExtension: "plist"), let data = try? Data(contentsOf: fileUrl) else {
            fatalError("Secrets file not found")
        }
        guard let secrets = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: String] else {
            fatalError("Secrets file is not in a correct format")
        }
        guard let clientId = secrets?["clientId"], let clientSecret = secrets?["clientSecret"] else {
            fatalError("Secrets file is missing data")
        }
        
        let selector = GithubSelector()
        
        let config = BaseConfig()
        config.clientId = clientId
        config.clientSecret = clientSecret
        
        let keychainKey = "github-token"
        
        let keychain = KeychainSwift()
        selector.didReceiveAuthToken = { token in
            keychain.set(token, forKey: keychainKey)
        }
        selector.logout = {
            keychain.delete(keychainKey)
        }
        if let token = keychain.get(keychainKey) {
            config.clientToken = token
        }
        
        selector.didSelectFile = { file in
            self.fileLabel.text = "Selected: \(file.name)"
        }
        
        selector.present(inViewController: self, configuration: config)
    }

}

