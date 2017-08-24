//
//  PresentImageView.swift
//  Pods
//
//  Created by Ondrej Rafaj on 23/08/2017.
//
//

import Foundation
import UIKit


class PresentImageView: PresentFileView {
    
    override var fileData: Data? {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.activityIndicator.alpha = 0
            }
            
            guard let fileData = fileData else {
                return
            }
            if let img = UIImage(data: fileData) {
                if img.size.width < imageView.frame.width && img.size.height < imageView.frame.height {
                    imageView.contentMode = .center
                }
                imageView.image = img
            }
        }
    }
    
    
    // MARK: Elements
    
    override func configureElements() {
        super.configureElements()
        
        imageView.image = Icons.image
    }
    
}
