//
//  NSCollectionLayoutItem+Ext.swift
//  ProjectB
//
//  Created by Dmytro on 2/26/24.
//

import UIKit

extension NSCollectionLayoutItem {
    public convenience init(fractionalSize: CGFloat) {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionalSize),
                                          heightDimension: .fractionalHeight(fractionalSize))
        
        self.init(layoutSize: size)
    }
}
