//
//  CommitTableViewCell.swift
//  Pods
//
//  Created by Ondrej Rafaj on 17/08/2017.
//
//

import Foundation
import Presentables
import Octokit
import SnapKit


class CommitTableViewCell: TableViewCell, Presentable {
    
    var commitNameLabel = UILabel()
    
    var commit: Commit? {
        didSet {
            commitNameLabel.text = commit?.sha
        }
    }
    
    // MARK: Elements
    
    override func layoutElements() {
        super.layoutElements()
        
        commitNameLabel.snp.makeConstraints { (make) in
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
        
        commitNameLabel.font = UIFont.systemFont(ofSize: 15)
        commitNameLabel.textColor = .black
        commitNameLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(commitNameLabel)
    }
    
}

class CommitTableViewCellPresenter: Presenter {
    
    var presentable: Presentable.Type = CommitTableViewCell.self
    
    var configure: ((Presentable) -> ())?
    
}
