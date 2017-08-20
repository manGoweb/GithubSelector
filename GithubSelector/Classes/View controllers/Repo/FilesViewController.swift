//
//  FilesViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 16/08/2017.
//
//

import Foundation
import UIKit
import Presentables


class FilesViewController: TableViewController {
    
    let dataManager = ReposDataController()
    
    var repo: Repository! {
        didSet {
            title = repo.name
        }
    }
    
    
    // MARK: Data
    
    private func setupDataManager() {
        var dc: PresentableManager = dataManager
        tableView.bind(withPresentableManager: &dc)
    }
    
    private func loadData() {
        guard let config = GithubSelector.shared.tokenConfig else {
            return
        }
        
        
    }
    
    // MARK: Elements
    
    func configureNavBar() {
        let info = UIBarButtonItem(title: "general.info".localized(), style: .plain, target: self, action: #selector(info(_:)))
        navigationItem.rightBarButtonItem = info
    }
    
    func configureTableView() {
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: Actions
    
    func info(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK View lifecycle
    
    override func loadView() {
        super.loadView()
        
        configureNavBar()
        configureTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
}
