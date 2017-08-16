//
//  WrapUpFooter.swift
//  Pods
//
//  Created by Ondrej Rafaj on 16/08/2017.
//
//

import Foundation
import UIKit
import Presentables
import SnapKit


class WrapUpFooter: HeaderFooterView, Presentable {
    
    let label = UILabel()
    
    
    // MARK: Elements
    
    override func layoutElements() {
        super.layoutElements()
        
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
    override func configureElements() {
        super.configureElements()
        
        contentView.backgroundColor = UIColor(white: 0, alpha: 0.08)
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .center
        contentView.addSubview(label)
    }
    
}


class WrapUpFooterPresenter: PresenterFooter {
    
    var presentable: Presentable.Type = WrapUpFooter.self
    
    var configure: ((Presentable) -> ())?
    
}
