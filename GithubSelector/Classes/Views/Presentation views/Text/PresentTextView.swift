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
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    var textView = UITextView()
    
    var file: File!
    
    var fileData: Data? {
        didSet {
            textView.text = String(data: fileData!, encoding: String.Encoding.utf8)
            
            UIView.animate(withDuration: 0.3) {
                self.activityIndicator.alpha = 0
            }
        }
    }
    
    
    // MARK: Elements
    
    override func layoutElements() {
        super.layoutElements()
        
        textView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.edges.equalTo(textView)
        }
    }
    
    override func configureElements() {
        super.configureElements()
        
        textView.isEditable = false
        textView.text = Localization.get("gs.general.loading")
        addSubview(textView)
        
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
    }
    
}
