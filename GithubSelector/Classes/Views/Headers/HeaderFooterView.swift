//
//  HeaderFooterView.swift
//  Pods
//
//  Created by Ondrej Rafaj on 16/08/2017.
//
//

import Foundation


class HeaderFooterView: UITableViewHeaderFooterView {
    
    
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
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
