//
//  RepoTableViewCell.swift
//  Pods
//
//  Created by Ondrej Rafaj on 15/08/2017.
//
//

import Foundation
import Presentables
import SnapKit


class RepoTableViewCell: TableViewCell, Presentable {
    
    var repoNameLabel = UILabel()
    var repoOwnerLabel = UILabel()
    var repoLastPushLabel = UILabel()
    var repoSizeLabel = UILabel()
    
    var privateImageView = UILabel()
    var forkImageView = UILabel()
    
    var repo: Repository? {
        didSet {
            guard let repo = self.repo else {
                return
            }
            repoNameLabel.text = repo.name
            repoOwnerLabel.text = repo.owner.login
            
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .medium
            
            let when: String
            if let lastPush = repo.lastPush {
                when = formatter.string(from: lastPush)
            }
            else {
                when = "general.never".localized()
            }
            repoLastPushLabel.text = "* Last push: \(when)"
            
            let fileSizeWithUnit = ByteCountFormatter.string(fromByteCount: Int64(repo.size * 1000), countStyle: .file)
            repoSizeLabel.text = "* Size: \(fileSizeWithUnit)"
            
            privateImageView.text = repo.isPrivate ? "P" : "O"
            privateImageView.backgroundColor = repo.isPrivate ? .red : .green
            forkImageView.text = (repo.isFork ?? false) ? "F" : ""
            forkImageView.backgroundColor = (repo.isFork ?? false) ? .orange : .clear
        }
    }
    
    // MARK: Elements
    
    override func layoutElements() {
        super.layoutElements()
        
        repoNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(6)
            make.left.equalTo(20)
            make.right.equalTo(privateImageView.snp.left).offset(-20)
        }
        
        repoOwnerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(repoNameLabel.snp.bottom).offset(2)
            make.left.width.equalTo(repoNameLabel)
        }
        
        repoLastPushLabel.snp.makeConstraints { (make) in
            make.top.equalTo(repoOwnerLabel.snp.bottom).offset(2)
            make.left.equalTo(repoOwnerLabel)
            make.bottom.lessThanOrEqualTo(-6)
        }
        
        repoSizeLabel.snp.makeConstraints { (make) in
            make.top.height.equalTo(repoLastPushLabel)
            make.left.equalTo(repoLastPushLabel.snp.right).offset(20)
            make.right.lessThanOrEqualTo(privateImageView.snp.left)
        }
        
        privateImageView.snp.makeConstraints { (make) in
            make.top.equalTo(repoNameLabel)
            make.right.equalTo(-4)
            make.width.height.equalTo(20)
        }
        
        forkImageView.snp.makeConstraints { (make) in
            make.top.equalTo(privateImageView.snp.bottom).offset(6)
            make.right.width.height.equalTo(privateImageView)
        }
    }
    
    override func configureElements() {
        super.configureElements()
        
        accessoryType = .disclosureIndicator
        
        repoNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        repoNameLabel.textColor = .black
        repoNameLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(repoNameLabel)
        
        repoOwnerLabel.font = UIFont.systemFont(ofSize: 12)
        repoOwnerLabel.textColor = .gray
        contentView.addSubview(repoOwnerLabel)
        
        repoLastPushLabel.font = UIFont.systemFont(ofSize: 10)
        repoLastPushLabel.textColor = .lightGray
        contentView.addSubview(repoLastPushLabel)
        
        repoSizeLabel.font = UIFont.systemFont(ofSize: 10)
        repoSizeLabel.textColor = .lightGray
        contentView.addSubview(repoSizeLabel)
        
        privateImageView.font = UIFont.systemFont(ofSize: 10)
        privateImageView.textColor = .white
        privateImageView.textAlignment = .center
        contentView.addSubview(privateImageView)
        
        forkImageView.font = UIFont.systemFont(ofSize: 10)
        forkImageView.textColor = .white
        forkImageView.textAlignment = .center
        contentView.addSubview(forkImageView)
    }
    
}

class RepoTableViewCellPresenter: Presenter {
    
    var presentable: Presentable.Type = RepoTableViewCell.self
    
    var configure: ((Presentable) -> ())?
    
}
