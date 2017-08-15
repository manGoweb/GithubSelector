//
//  TableViewCell.swift
//  Pods
//
//  Created by Ondrej Rafaj on 16/08/2017.
//
//

import Foundation
import UIKit


class TableViewCell: UITableViewCell {
    
    
    // MARK: Elements
    
    func layoutElements() {
        
    }
    
    func setStyles() {
        
    }
    
    func configureElements() {
        
    }
    
    // MARK: Initialization
    
    private func setup() {
        configureElements()
        setStyles()
        layoutElements()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
