//
//  ReposDataController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 16/08/2017.
//
//

import Foundation
import Presentables


class ReposDataController: PresentableTableViewDataManager {
    
    var indexLetters: [String] = []
    var originalDataInSections: [[Repository]] = []
    
    // MARK: Data
    
    func convertData(repos: [Repository]) {
        data = []
        
        indexLetters = []
        originalDataInSections = []
        
        let sortedRepos = repos.sorted { $0.name!.lowercased() < $1.name!.lowercased() }
        
        var lastSection: PresentableSection!
        var lastDataSection: [Repository]!
        
        for repo: Repository in sortedRepos {
            let firstLetter: String = ((repo.name != nil) ? "\(repo.name!.first ?? "-")" : "-").uppercased()
            if !indexLetters.contains(firstLetter) {
                indexLetters.append(firstLetter)
                
                if lastSection != nil {
                    data.append(lastSection)
                    originalDataInSections.append(lastDataSection)
                }
                lastSection = PresentableSection()
                lastDataSection = []
            }
            
            let presenter = RepoTableViewCellPresenter()
            presenter.configure = { presentable in
                guard let cell = presentable as? RepoTableViewCell else {
                    return
                }
                cell.repo = repo
            }
            
            lastSection.presenters.append(presenter)
            lastDataSection.append(repo)
        }
        
        // LAst section will have a total footer
        let footer = WrapUpFooterPresenter()
        footer.configure = { presentable in
            guard let footer = presentable as? WrapUpFooter else {
                return
            }
            footer.label.text = Localization.get("gs.general.total", repos.count)
        }
        lastSection.footer = footer
        
        // Append the last remaining section
        data.append(lastSection)
        originalDataInSections.append(lastDataSection)
        
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section == (data.count - 1) else {
            return 0
        }
        return 44
    }
    
}
