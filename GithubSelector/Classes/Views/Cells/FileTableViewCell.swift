//
//  FileTableViewCell.swift
//  Pods
//
//  Created by Ondrej Rafaj on 21/08/2017.
//
//

import Foundation
import Presentables
import SnapKit


class FileTableViewCell: TableViewCell, Presentable {
    
    var fileNameLabel = UILabel()
    var fileSizeLabel = UILabel()
    var fileModeLabel = UILabel()
    
    var fileIconImageView = UIImageView()
    
    var file: File? {
        didSet {
            fileNameLabel.text = file?.path
            
            if let size = file?.size {
                let fileSizeWithUnit = ByteCountFormatter.string(fromByteCount: Int64(size * 1000), countStyle: .file)
                fileSizeLabel.text = "* Size: \(fileSizeWithUnit)"
            }
            else {
                fileSizeLabel.text = "beneral.folder".localized()
            }
            
            if let mode = file?.mode {
                fileModeLabel.text = "CHMOD: \(mode)"
            }
            
            if file?.type == "tree" {
                accessoryType = .disclosureIndicator
            }
            else {
                accessoryType = .none
            }
        }
    }
    
    // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: Elements
    
    override func layoutElements() {
        super.layoutElements()
        
        fileIconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(6)
            make.height.equalTo(36)
            make.width.equalTo(fileIconImageView.snp.height)
        }
        
        fileNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(6)
            make.left.equalTo(fileIconImageView.snp.right).offset(12)
            make.right.equalTo(-20)
            make.height.greaterThanOrEqualTo(20)
        }
        
        fileSizeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fileNameLabel.snp.bottom).offset(2)
            make.left.equalTo(fileNameLabel)
            make.bottom.lessThanOrEqualTo(-6)
        }
        
        fileModeLabel.snp.makeConstraints { (make) in
            make.top.height.equalTo(fileSizeLabel)
            make.left.equalTo(fileSizeLabel.snp.right).offset(20)
            make.right.lessThanOrEqualTo(fileNameLabel)
        }
    }
    
    override func configureElements() {
        super.configureElements()
        
        fileIconImageView.contentMode = .scaleAspectFit
        fileIconImageView.backgroundColor = .white
        fileIconImageView.layer.borderColor = UIColor.lightGray.cgColor
        fileIconImageView.layer.borderWidth = 2
        contentView.addSubview(fileIconImageView)
        
        fileNameLabel.font = UIFont.systemFont(ofSize: 15)
        fileNameLabel.textColor = .black
        fileNameLabel.lineBreakMode = .byTruncatingTail
        fileNameLabel.numberOfLines = 1
        contentView.addSubview(fileNameLabel)
        
        fileSizeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        fileSizeLabel.textColor = .darkGray
        fileSizeLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(fileSizeLabel)
        
        fileModeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        fileModeLabel.textColor = .darkGray
        fileModeLabel.lineBreakMode = .byTruncatingTail
        fileModeLabel.textAlignment = .right
        contentView.addSubview(fileModeLabel)
    }
    
}

class FileTableViewCellPresenter: Presenter {
    
    var presentable: Presentable.Type = FileTableViewCell.self
    
    var configure: ((Presentable) -> ())?
    
}
