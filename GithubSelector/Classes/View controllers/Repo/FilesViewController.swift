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
            let file: File = self.dataManager.originalData[info.indexPath.row]
            
            let c = FilesViewController()
            c.repo = self.repo
            c.file = file
            
            self.navigationController?.pushViewController(c, animated: true)
        }
        var dc: PresentableManager = dataManager
        tableView.bind(withPresentableManager: &dc)
    }
    
    private func loadData() {
        guard let config = GithubSelector.shared.tokenConfig else {
            return
        }
        
        let sha: String = commit?.sha ?? file?.sha ?? ""
        Octokit(config).tree(owner: repo.owner.login!, repo: repo.name!, sha: sha) { (response) in
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
    
    // MARK: Elements
    
    func configureNavBar() {
        
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
