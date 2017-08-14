//
//  HomeViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 14/08/2017.
//
//

import Foundation
import UIKit


class HomeViewController: TableViewController {
    
    
    // MARK View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if GithubSelector.shared.configuration.clientToken == nil {
            let nc = UINavigationController(rootViewController: LoginViewController())
            nc.modalTransitionStyle = .crossDissolve
            present(nc, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
