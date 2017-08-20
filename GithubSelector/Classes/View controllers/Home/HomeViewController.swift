//
//  HomeViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 14/08/2017.
//
//

import Foundation
import UIKit
import Presentables


class HomeViewController: TableViewController {
    
    let dataManager = ReposDataController()
    var didLoadData: Bool = false
    
    
    // MARK: Data
    
    private func setupDataManager() {
        dataManager.didTapCell = { info in
            self.tableView.deselectRow(at: info.indexPath, animated: true)
            let repo: Repository = self.dataManager.originalDataInSections[info.indexPath.section][info.indexPath.row]
            
            let c = BranchesViewController()
            c.repo = repo
            self.navigationController?.pushViewController(c, animated: true)
        }
        
        var dc: PresentableManager = dataManager
        tableView.bind(withPresentableManager: &dc)
    }
    
    let perPage: Int = 100
    
    private func loadData() {
        guard let config = GithubSelector.shared.tokenConfig else {
            return
        }
        
        // TODO: Add loading
        var allRepos: [Repository] = []
        
        loadData(config) { repos in
            allRepos.append(contentsOf: repos)
            if repos.count < self.perPage {
                self.didLoadData = true
                self.dataManager.convertData(repos: allRepos)
            }
        }
    }
    
    private func loadData(_ config: TokenConfiguration, page: Int = 1, completion: @escaping ((_ repos: [Repository])->())) {
        Octokit(config).repositories(page: String(page), perPage: String(perPage)) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let repos):
                    completion(repos)
                    if repos.count == self.perPage {
                        self.loadData(config, page: (page + 1), completion: completion)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    // MARK: Elements
    
    func configureNavBar() {
        let close = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close(_:)))
        navigationItem.leftBarButtonItem = close
        
        let logout = UIBarButtonItem(title: "general.logout".localized(), style: .plain, target: self, action: #selector(logout(_:)))
        navigationItem.rightBarButtonItem = logout
    }
    
    func configureTableView() {
        tableView.sectionIndexBackgroundColor = UIColor(white: 1, alpha: 0.08)
        tableView.estimatedSectionHeaderHeight = 44
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.estimatedSectionFooterHeight = 0
        tableView.sectionFooterHeight = UITableViewAutomaticDimension
}
    
    // MARK: Actions
    
    func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func logout(_ sender: UIBarButtonItem) {
        GithubSelector.shared.configuration.clientToken = nil
        GithubSelector.shared.logout?()
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK View lifecycle
    
    override func loadView() {
        super.loadView()
        
        configureNavBar()
        configureTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if GithubSelector.shared.configuration.clientToken == nil {
            let nc = UINavigationController(rootViewController: LoginViewController())
            nc.modalTransitionStyle = .crossDissolve
            present(nc, animated: true, completion: nil)
        }
        
        setupDataManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !didLoadData {
            loadData()
        }
    }
    
}
