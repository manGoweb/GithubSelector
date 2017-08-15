//
//  ReposDataController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 16/08/2017.
//
//

import Foundation
import Octokit
import Presentables


class ReposDataController: PresentableTableViewDataManager {
    
    var indexLetters: [String] = []
    
    // MARK: Data
    
    func convertData(repos: [Repository]) {
        data = []
        
        indexLetters = []
        
        let sortedRepos = repos.sorted { $0.name!.lowercased() < $1.name!.lowercased() }
        
        var lastSection: PresentableSection!
        
        for repo: Repository in sortedRepos {
            let firstLetter: String = ((repo.name != nil) ? "\(repo.name!.characters.first ?? "-")" : "-").uppercased()
            if !indexLetters.contains(firstLetter) {
                indexLetters.append(firstLetter)
                
                if lastSection != nil {
                    data.append(lastSection)
                }
                lastSection = PresentableSection()
            }
            
            let presenter = RepoTableViewCellPresenter()
            presenter.configure = { presentable in
                guard let cell = presentable as? RepoTableViewCell else {
                    return
                }
                cell.repo = repo
            }
            
            lastSection.presenters.append(presenter)
        }
        
        self.needsReloadData?()
    }
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        let section = PresentableSection()
        section.presenters = [LoadingTableViewCellPresenter()]
        data.append(section)
    }
    
    // MARK: Table view overrides
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexLetters
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard indexLetters.count > section else {
            return "-"
        }
        return indexLetters[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
}
