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
    
    @objc func startSelectingFiles(_ sender: UIButton) {
        let config = Config()
        
        let keychain = KeychainSwift()
        if let token = keychain.get(config.keychainKey) {
            config.clientToken = token
        }
        
        let selector = GithubSelector(configuration: config)
        
        selector.logout = {
            keychain.delete(config.keychainKey)
        }
        selector.didSelectFile = { file in
            self.fileLabel.text = "Selected: \(file.name)"
        }
        
        selector.present(inViewController: self)
    }

}

