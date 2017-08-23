//
//  View.swift
//  Pods
//
//  Created by Ondrej Rafaj on 23/08/2017.
//
//

import Foundation
import UIKit


class View: UIView {
    
    
    // MARK: Elements
    
    func configureElements() {
        
    }
    
    func layoutElements() {
        
    }
    
    // MARK: Initialization
    
    private func setup() {
        configureElements()
        layoutElements()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
