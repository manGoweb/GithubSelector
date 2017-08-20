//
//  CommitsDataController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 17/08/2017.
//
//

import Foundation
import Presentables


class CommitsDataController: PresentableTableViewDataManager {
    
    var indexLetters: [String] = []
    var originalDataInSections: [[Commit]] = []
    
    // MARK: Data
    
    func convertData(commits: [Commit]) {
        data = []
        
        //let sortedBranches = branches.sorted { $0.name!.lowercased() < $1.name!.lowercased() }
        
        let sortedCommits = commits
        
        let section = PresentableSection()
        for commit: Commit in sortedCommits {
            let presenter = CommitTableViewCellPresenter()
            presenter.configure = { presentable in
                guard let cell = presentable as? CommitTableViewCell else {
                    return
                }
                cell.commit = commit
            }
            
            section.presenters.append(presenter)
        }
        
        let footer = WrapUpFooterPresenter()
        footer.configure = { presentable in
            guard let footer = presentable as? WrapUpFooter else {
                return
            }
            footer.label.text = "Total: \(commits.count)"
        }
        section.footer = footer
        
        data.append(section)
        
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
        if data.count == 1 {
            return nil
        }
        return indexLetters
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if data.count == 1 {
            return nil
        }
        guard indexLetters.count > section else {
            return "-"
        }
        return indexLetters[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard data.count > 1 else {
            return 0
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section == (data.count - 1) || data.count == 1 else {
            return 0
        }
        return 44
    }
    
}
