//
//  BranchesDataController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 17/08/2017.
//
//

import Foundation
import Presentables


class BranchesDataController: PresentableTableViewDataManager {
    
    var indexLetters: [String] = []
    var originalDataInSections: [[Branch]] = []
    
    // MARK: Data
    
    func convertData(branches: [Branch]) {
        data = []
        indexLetters = []
        originalDataInSections = []
        
        //let sortedBranches = branches.sorted { $0.name!.lowercased() < $1.name!.lowercased() }
        
        let sortedBranches = branches
        
        if branches.count < 12 {
            originalDataInSections.append(branches)
            
            let section = PresentableSection()
            for branch: Branch in sortedBranches {
                let presenter = BranchTableViewCellPresenter()
                presenter.configure = { presentable in
                    guard let cell = presentable as? BranchTableViewCell else {
                        return
                    }
                    cell.branch = branch
                }
                
                section.presenters.append(presenter)
            }
            
            let footer = WrapUpFooterPresenter()
            footer.configure = { presentable in
                guard let footer = presentable as? WrapUpFooter else {
                    return
                }
                footer.label.text = Localization.get("gs.general.total", branches.count)
            }
            section.footer = footer
            
            data.append(section)
        }
        else {
            var lastSection: PresentableSection!
            var lastDataSection: [Branch]!
            
            for branch: Branch in sortedBranches {
                let firstLetter: String = ((branch.name != nil) ? "\(branch.name!.first ?? "-")" : "-").uppercased()
                if !indexLetters.contains(firstLetter) {
                    indexLetters.append(firstLetter)
                    
                    if lastSection != nil {
                        data.append(lastSection)
                        originalDataInSections.append(lastDataSection)
                    }
                    lastSection = PresentableSection()
                    lastDataSection = []
                }
                
                let presenter = BranchTableViewCellPresenter()
                presenter.configure = { presentable in
                    guard let cell = presentable as? BranchTableViewCell else {
                        return
                    }
                    cell.branch = branch
                }
                
                lastSection.presenters.append(presenter)
                lastDataSection.append(branch)
            }
            
            // Last section will have a total footer
            let footer = WrapUpFooterPresenter()
            footer.configure = { presentable in
                guard let footer = presentable as? WrapUpFooter else {
                    return
                }
                footer.label.text = Localization.get("gs.general.loading")
            }
            lastSection.footer = footer
            
            // Append the last remaining section
            data.append(lastSection)
            originalDataInSections.append(lastDataSection)
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
