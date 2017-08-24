//
//  PresentTextView.swift
//  Pods
//
//  Created by Ondrej Rafaj on 23/08/2017.
//
//

import Foundation
import UIKit
import SnapKit


class PresentTextView: View, PresentView {
    
    var textView = UITextView()
    
    var file: File!
    
    var fileData: Data? {
        didSet {
            textView.text = String(data: fileData!, encoding: String.Encoding.utf8)
        }
    }
    
    
    // MARK: Elements
    
    override func layoutElements() {
        super.layoutElements()
        
        textView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureElements() {
        super.configureElements()
        
        textView.isEditable = false
        addSubview(textView)
    }
    
}
