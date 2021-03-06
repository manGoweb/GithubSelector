//
//  Presentables+UICollectionView.swift
//  Presentables
//
//  Created by Ondrej Rafaj on 30/11/2017.
//

import Foundation
import UIKit


fileprivate extension Array where Element == UICollectionViewCell.Type {
    
    func contains(className: AnyClass) -> Bool {
        return self.filter({$0 === className}).count > 0
    }
    
}

extension UICollectionView: PresentableCollectionElement {
    
    func safeReloadData() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    public func bind(withPresentableManager manager: inout CollectionViewPresentableManager) {
        let m = manager
        manager.bindableData.bind(listener: { (data) in
            for section: PresentableSection in m.data {
                self.register(section: section)
            }
            self.safeReloadData()
        })
        
        register(presentableSections: &manager.data)
        
        manager.needsReloadData = {
            self.safeReloadData()
        }
        
        dataSource = manager as? UICollectionViewDataSource
        delegate = manager as? UICollectionViewDelegate
    }
    
    func register(presentableSections sections: inout PresentableSections) {
        guard sections.count > 0 else {
            return
        }
        
        for  i in 0 ... (sections.count - 1) {
            let section: PresentableSection = sections[i]
            register(section: section)
        }
        
        safeReloadData()
    }
    
    // MARK: Helpers
    
    func register(section: PresentableSection) {
        DispatchQueue.global().async {
            if section.bindableHeader.listener == nil {
                section.bindableHeader.bind(listener: { (header) in
                    self.safeReloadData()
                })
            }
            if section.bindableFooter.listener == nil {
                section.bindableFooter.bind(listener: { (footer) in
                    self.safeReloadData()
                })
            }
            if section.bindablePresenters.listener == nil {
                section.bindablePresenters.bind(listener: { (presenters) in
                    self.safeReloadData()
                })
            }
        }
    }
    
}
