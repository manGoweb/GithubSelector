//
//  BranchesViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 17/08/2017.
//
//

import Foundation
import UIKit
import Octokit
import Presentables


class BranchesViewController: TableViewController {
    
    let dataManager = BranchesDataController()
    
    var repo: Repository! {
        didSet {
            title = repo.name
        }
    }
    
    // MARK: Data
    
    private func setupDataManager() {
        dataManager.didTapCell = { info in
            self.tableView.deselectRow(at: info.indexPath, animated: true)
            let branch: Branch = self.dataManager.originalDataInSections[info.indexPath.section][info.indexPath.row]
            self.navigate(to: branch)
        }
        
        var dc: PresentableManager = dataManager
        tableView.bind(withPresentableManager: &dc)
    }
    
    private func loadData() {
        guard let config = GithubSelector.shared.tokenConfig else {
            return
        }
        
        Octokit(config).branches(owner: repo.owner.login!, repo: repo.name!) { (response) in
            switch response {
            case .success(let branches):
                self.didLoadData = true
                
                self.dataManager.convertData(branches: branches)
                
                if branches.count == 1 {
                    self.navigate(to: branches.first!)
                }
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
    
    // MARK: Navigation
    
    func navigate(to branch: Branch, animated: Bool = true) {
        let c = CommitsViewController()
        c.repo = repo
        c.branch = branch
        
        navigationController?.pushViewController(c, animated: animated)
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
    
    var didLoadData: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !didLoadData {
            loadData()
        }
    }
    
}
