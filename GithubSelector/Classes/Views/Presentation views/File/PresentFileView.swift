//
//  PresentFileView.swift
//  Pods
//
//  Created by Ondrej Rafaj on 23/08/2017.
//
//

import Foundation
import UIKit
import SnapKit


class PresentFileView: View, PresentView {
    
    var file: File! {
        didSet {
            fileNameLabel.text = file.path
            
            let fileSizeWithUnit = ByteCountFormatter.string(fromByteCount: Int64(file.size), countStyle: .file)
            fileSizeLabel.text = Localization.get("gs.files.size", fileSizeWithUnit)
            fileModeLabel.text = Localization.get("gs.files.chmod.full", String(file.mode!.characters.suffix(3)))
        }
    }
    
    var fileData: Data? {
        didSet {
            
        }
    }
    
    let iconImageView = UIImageView()
    let fileNameLabel = UILabel()
    let fileSizeLabel = UILabel()
    let fileModeLabel = UILabel()
    
    
    // MARK: Elements
    
    override func layoutElements() {
        super.layoutElements()
        
        iconImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(snp.centerY).offset(-60)
            make.height.equalTo(100)
            make.left.equalTo(44)
            make.right.equalTo(-44)
        }
        
        fileNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(44)
            make.left.right.equalTo(iconImageView)
        }
        
        fileSizeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fileNameLabel.snp.bottom).offset(20)
            make.left.right.equalTo(fileNameLabel)
        }
        
        fileModeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fileSizeLabel.snp.bottom).offset(4)
            make.left.right.equalTo(fileSizeLabel)
        }
    }
    
    private func configureImageView() {
        iconImageView.tintColor = .gray
        iconImageView.image = Icons.file.withRenderingMode(.alwaysTemplate)
        iconImageView.contentMode = .scaleAspectFit
        addSubview(iconImageView)
    }
    
    private func configureLabels() {
        fileNameLabel.textAlignment = .center
        fileNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        fileNameLabel.textColor = .black
        fileNameLabel.numberOfLines = 3
        fileNameLabel.lineBreakMode = .byTruncatingTail
        addSubview(fileNameLabel)
        
        fileSizeLabel.textAlignment = .center
        fileSizeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        fileSizeLabel.textColor = .gray
        addSubview(fileSizeLabel)
        
        fileModeLabel.textAlignment = .center
        fileModeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        fileModeLabel.textColor = .gray
        addSubview(fileModeLabel)
    }
    
    override func configureElements() {
        super.configureElements()
        
        configureImageView()
        configureLabels()
    }
    
}
