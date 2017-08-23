//
//  LoadingTableViewCell.swift
//  Pods
//
//  Created by Ondrej Rafaj on 16/08/2017.
//
//

import Foundation
import Presentables
import SnapKit


class LoadingTableViewCell: TableViewCell, Presentable {
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    // MARK: Elements
    
    override func layoutElements() {
        super.layoutElements()
        
        activityIndicator.snp.makeConstraints { (make) in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(-20)
        }
    }
    
    override func configureElements() {
        super.configureElements()
        
        textLabel?.text = Localization.get("gs.general.loading")
        
        activityIndicator.startAnimating()
        contentView.addSubview(activityIndicator)
        
        selectionStyle = .none
    }
    
}

class LoadingTableViewCellPresenter: Presenter {
    
    var presentable: Presentable.Type = LoadingTableViewCell.self
    
    var configure: ((Presentable) -> ())?
    
}
