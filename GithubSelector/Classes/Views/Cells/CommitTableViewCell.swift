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
    
    var commitMessageLabel = UILabel()
    var commitAuthorLabel = UILabel()
    var commitDateLabel = UILabel()
    var commitHashLabel = UILabel()
    
    var commitAuthorImageView = UIImageView()
    
    var commit: Commit? {
        didSet {
            commitMessageLabel.text = commit?.commitMessage
            commitAuthorLabel.text = commit?.authored?.name
            
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .medium
            
            let when: String
            if let lastPush = commit?.authored?.date {
                when = formatter.string(from: lastPush)
            }
            else {
                when = "general.never".localized()
            }
            commitDateLabel.text = "* on \(when)"
            
            if let hash = commit?.sha {
                commitHashLabel.text = "#\(String(hash.characters.prefix(7)))"
            }
        }
    }
    
    // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        commitAuthorImageView.layer.cornerRadius = (commitAuthorImageView.frame.height / 2)
    }
    
    // MARK: Elements
    
    override func layoutElements() {
        super.layoutElements()
        
        commitAuthorImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(6)
            make.bottom.equalTo(commitAuthorLabel.snp.bottom)
            make.width.equalTo(commitAuthorImageView.snp.height)
        }
        
        commitMessageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(6)
            make.left.equalTo(commitAuthorImageView.snp.right).offset(12)
            make.right.equalTo(-20)
            make.height.equalTo(20)
        }
        
        commitAuthorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(commitMessageLabel.snp.bottom).offset(2)
            make.left.equalTo(commitMessageLabel)
            make.height.equalTo(14)
            make.bottom.lessThanOrEqualTo(-6)
        }
        
        commitDateLabel.snp.makeConstraints { (make) in
            make.top.height.equalTo(commitAuthorLabel)
            make.left.equalTo(commitAuthorLabel.snp.right).offset(4)
        }
        
        commitHashLabel.snp.makeConstraints { (make) in
            make.top.height.equalTo(commitAuthorLabel)
            make.left.equalTo(commitDateLabel.snp.right).offset(20)
            make.right.lessThanOrEqualTo(commitMessageLabel)
        }
    }
    
    override func configureElements() {
        super.configureElements()
        
        accessoryType = .disclosureIndicator
        
        commitAuthorImageView.contentMode = .scaleAspectFit
        commitAuthorImageView.backgroundColor = .white
        commitAuthorImageView.layer.borderColor = UIColor.lightGray.cgColor
        commitAuthorImageView.layer.borderWidth = 2
        contentView.addSubview(commitAuthorImageView)
        
        commitMessageLabel.font = UIFont.systemFont(ofSize: 15)
        commitMessageLabel.textColor = .black
        commitMessageLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(commitMessageLabel)
        
        commitAuthorLabel.font = UIFont.boldSystemFont(ofSize: 12)
        commitAuthorLabel.textColor = .darkGray
        commitAuthorLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(commitAuthorLabel)
        
        commitDateLabel.font = UIFont.boldSystemFont(ofSize: 12)
        commitDateLabel.textColor = .darkGray
        commitDateLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(commitDateLabel)
        
        commitHashLabel.font = UIFont.boldSystemFont(ofSize: 12)
        commitHashLabel.textColor = .darkGray
        commitHashLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(commitHashLabel)
    }
    
}

class CommitTableViewCellPresenter: Presenter {
    
    var presentable: Presentable.Type = CommitTableViewCell.self
    
    var configure: ((Presentable) -> ())?
    
}
