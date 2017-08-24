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
    
    let dataManager = FilesDataController()
    
    var repo: Repository!
    var isRootFolder: Bool = false
    
    var commit: Commit? {
        didSet {
            title = commit?.commitMessage
        }
    }
    
    var file: File? {
        didSet {
            title = file?.path
        }
    }
    
    var didLoadData: Bool = false
    
    
    // MARK: Data
    
    private func setupDataManager() {
        dataManager.didTapCell = { info in
            if let _ = info.presenter as? LoadingTableViewCellPresenter {
                return
            }
            
            let file: File = self.dataManager.originalData[info.indexPath.row]
            
            if file.type == "tree" {
                let c = FilesViewController()
                c.githubSelector = self.githubSelector
                c.repo = self.repo
                c.file = file
                self.navigationController?.pushViewController(c, animated: true)
            }
            else {
                let c = FilePreviewViewController()
                c.githubSelector = self.githubSelector
                c.repo = self.repo
                c.file = file
                self.navigationController?.pushViewController(c, animated: true)
            }
        }
        var dc: PresentableManager = dataManager
        tableView.bind(withPresentableManager: &dc)
    }
    
    private func loadData() {
        guard let config = githubSelector.tokenConfig else {
            return
        }
        
        let load: (()->()) = {
            let sha: String = self.commit?.sha ?? self.file?.sha ?? ""
            _ = Octokit(config).tree(owner: self.repo.owner.login!, repo: self.repo.name!, sha: sha) { (response) in
                switch response {
                case .success(let tree):
                    self.didLoadData = true
                    
                    self.dataManager.convertData(tree: tree)
                    
                    if tree.files.count == 1 {
                        //self.navigate(to: branches.first!)
                    }
                case .failure(let error):
                    print(error)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        if commit == nil && file == nil {
            _ = Octokit(config).commits(owner: repo.owner.login!, repo: repo.name!, branch: repo.defaultBranch!, perPage: "1") { (response) in
                switch response {
                case .success(let commits):
                    if commits.count > 0 {
                        self.commit = commits.first
                        load()
                    }
                case .failure(let error):
                    print(error)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        else {
            load()
        }
    }
    
    // MARK: Elements
    
    func configureNavBar() {
        if isRootFolder {
            let branch = UIBarButtonItem(title: Localization.get("gs.files.change-branch"), style: .plain, target: self, action: #selector(changeBranchTapped(_:)))
            navigationItem.rightBarButtonItem = branch
        }
    }
    
    func configureTableView() {
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: Actions
    
    func changeBranchTapped(_ sender: UIBarButtonItem) {
        let c = BranchesViewController()
        c.githubSelector = githubSelector
        c.repo = repo
        self.navigationController?.pushViewController(c, animated: true)
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
