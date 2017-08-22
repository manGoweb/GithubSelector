//
//  FilesDataController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 21/08/2017.
//
//

import Foundation
import Presentables


class FilesDataController: PresentableTableViewDataManager {
    
    var originalData: [File]!
    
    // MARK: Data
    
    func convertData(tree: Tree) {
        data = []
        
        var sortedFiles: [File] = tree.files.sorted { $0.path!.lowercased() < $1.path!.lowercased() }
        
        let folders: [File] = sortedFiles.filter { (file) -> Bool in
            return file.type == "tree"
        }
        let files: [File] = sortedFiles.filter { (file) -> Bool in
            return file.type != "tree"
        }
        
        var newData: [File] = folders
        newData.append(contentsOf: files)
        
        originalData = newData
        
        let section = PresentableSection()
        for file: File in newData {
            let presenter = FileTableViewCellPresenter()
            presenter.configure = { presentable in
                guard let cell = presentable as? FileTableViewCell else {
                    return
                }
                cell.file = file
            }
            
            section.presenters.append(presenter)
        }
        
        let footer = WrapUpFooterPresenter()
        footer.configure = { presentable in
            guard let footer = presentable as? WrapUpFooter else {
                return
            }
            footer.label.text = "Total: \(sortedFiles.count)"
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section == (data.count - 1) || data.count == 1 else {
            return 0
        }
        return 44
    }
    
}
