//
//  CommitTableViewCell.swift
//  Pods
//
//  Created by Ondrej Rafaj on 17/08/2017.
//
//

import Foundation
import Presentables
import SnapKit


class CommitTableViewCell: TableViewCell, Presentable {
    
    var commitMessageLabel = UILabel()
    var commitAuthorLabel = UILabel()
    var commitDateLabel = UILabel()
    var commitHashLabel = UILabel()
    
    var commitAuthorImageView = UIImageView()
    
    var commit: Commit? {
        didSet {
            // Message and author
            commitMessageLabel.text = commit?.commitMessage
            commitAuthorLabel.text = (commit?.author?.login ?? (commit?.authored?.name ?? Localization.get("gs.general.unknown")))
            
            // Commit date
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .medium
            
            let when: String
            if let lastPush = commit?.authored?.date {
                when = formatter.string(from: lastPush)
            }
            else {
                when = Localization.get("gs.general.never")
            }
            commitDateLabel.text = Localization.get("gs.commits.commited_on", when)
            
            // Commit hash
            if let hash = commit?.sha {
                commitHashLabel.text = "#\(String(hash.characters.prefix(7)))"
            }
            
            // User avatar
            commitAuthorImageView.image = Icons.user.withRenderingMode(.alwaysTemplate)
            if let url = commit?.author?.avatarURL {
                Downloader.shared.get(url: url) { (result) in
                    switch result {
                    case .success(let image):
                        UIView.transition(with: self.commitAuthorImageView, duration: 0.0, animations: {
                            self.commitAuthorImageView.image = image.withRenderingMode(.alwaysOriginal)
                        }, completion: nil)
                    default:
                        break
                    }
                }
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
            make.height.equalTo(36)
            make.width.equalTo(commitAuthorImageView.snp.height)
        }
        
        commitMessageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(6)
            make.left.equalTo(commitAuthorImageView.snp.right).offset(12)
            make.right.equalTo(-20)
            make.height.greaterThanOrEqualTo(20)
        }
        
        commitAuthorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(commitMessageLabel.snp.bottom).offset(2)
            make.left.equalTo(commitMessageLabel)
            make.bottom.lessThanOrEqualTo(-6)
        }
        
        commitDateLabel.snp.makeConstraints { (make) in
            make.top.height.equalTo(commitAuthorLabel)
            make.left.equalTo(commitAuthorLabel.snp.right).offset(4)
        }
        
        commitHashLabel.snp.makeConstraints { (make) in
            make.top.height.equalTo(commitAuthorLabel)
            make.left.equalTo(commitDateLabel.snp.right).offset(20)
            make.right.equalTo(commitMessageLabel)
        }
    }
    
    override func configureElements() {
        super.configureElements()
        
        accessoryType = .disclosureIndicator
        
        commitAuthorImageView.contentMode = .scaleAspectFit
        commitAuthorImageView.backgroundColor = .white
        commitAuthorImageView.layer.borderColor = UIColor.lightGray.cgColor
        commitAuthorImageView.layer.borderWidth = 2
        commitAuthorImageView.clipsToBounds = true
        commitAuthorImageView.tintColor = UIColor(white: 0, alpha: 0.1)
        contentView.addSubview(commitAuthorImageView)
        
        commitMessageLabel.font = UIFont.systemFont(ofSize: 15)
        commitMessageLabel.textColor = .black
        commitMessageLabel.lineBreakMode = .byTruncatingTail
        commitMessageLabel.numberOfLines = 1
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
        commitHashLabel.textAlignment = .right
        contentView.addSubview(commitHashLabel)
    }
    
}

class CommitTableViewCellPresenter: Presenter {
    
    var presentable: Presentable.Type = CommitTableViewCell.self
    
    var configure: ((Presentable) -> ())?
    
}
