//
//  CommitsViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 17/08/2017.
//
//

import Foundation
import UIKit
import Octokit
import Presentables


class CommitsViewController: TableViewController {
    
    let dataManager = CommitsDataController()
    
    var repo: Repository!
    
    var branch: Branch! {
        didSet {
            title = branch.name
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
        
        Octokit(config).commits(owner: repo.owner.login!, repo: repo.name!, branch: branch.name!) { (response) in
            switch response {
            case .success(let commits):
                self.dataManager.convertData(commits: commits)
            case .failure(let error):
                print(error)
                self.navigationController?.popViewController(animated: true)
            }
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
