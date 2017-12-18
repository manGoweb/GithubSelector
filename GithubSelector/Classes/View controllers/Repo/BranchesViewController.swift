//
//  BranchesViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 17/08/2017.
//
//

import Foundation
import UIKit
import Presentables


class BranchesViewController: TableViewController {
    
    let dataManager = BranchesDataController()
    
    var repo: Repository! {
        didSet {
            title = repo.name
        }
    }
    
    var didLoadData: Bool = false
    
    // MARK: Data
    
    private func setupDataManager() {
        dataManager.didTapCell = { info in
            if let _ = info.presenter as? LoadingTableViewCellPresenter {
                return
            }
            
            self.tableView.deselectRow(at: info.indexPath, animated: true)
            let branch: Branch = self.dataManager.originalDataInSections[info.indexPath.section][info.indexPath.row]
            self.navigate(to: branch)
        }
        
        var dc: TableViewPresentableManager = dataManager
        tableView.bind(withPresentableManager: &dc)
    }
    
    private func loadData() {
        guard let config = githubSelector.tokenConfig else {
            return
        }
        
        _ = Octokit(config).branches(owner: repo.owner.login!, repo: repo.name!) { (response) in
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
    
    func configureTableView() {
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: Navigation
    
    func navigate(to branch: Branch, animated: Bool = true) {
        let c = CommitsViewController()
        c.githubSelector = githubSelector
        c.repo = repo
        c.branch = branch
        navigationController?.pushViewController(c, animated: animated)
    }
    
    // MARK View lifecycle
    
    override func loadView() {
        super.loadView()
        
        configureTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !didLoadData {
            loadData()
        }
    }
    
}
