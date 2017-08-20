//
//  BranchTableViewCell.swift
//  Pods
//
//  Created by Ondrej Rafaj on 17/08/2017.
//
//

import Foundation
import Presentables
import SnapKit


class BranchTableViewCell: TableViewCell, Presentable {
    
    var branchNameLabel = UILabel()

    
    var branch: Branch? {
        didSet {
            guard let branch = self.branch else {
                return
            }
            
            branchNameLabel.font = (branch.name!.lowercased() == "master") ? UIFont.boldSystemFont(ofSize: 15) : UIFont.systemFont(ofSize: 15)
            
            branchNameLabel.text = branch.name

        }
    }
    
    // MARK: Elements
    
    override func layoutElements() {
        super.layoutElements()
        
        branchNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(6)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(20)
            make.bottom.greaterThanOrEqualTo(-6)
        }
    }
    
    override func configureElements() {
        super.configureElements()
        
        accessoryType = .disclosureIndicator
        
        branchNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        branchNameLabel.textColor = .black
        branchNameLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(branchNameLabel)
    }
    
}

class BranchTableViewCellPresenter: Presenter {
    
    var presentable: Presentable.Type = BranchTableViewCell.self
    
    var configure: ((Presentable) -> ())?
    
}
