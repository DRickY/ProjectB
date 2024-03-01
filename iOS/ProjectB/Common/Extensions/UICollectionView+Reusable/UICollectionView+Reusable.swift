//
//  UICollectionView+Reusable.swift
//  ProjectB
//
//  Created by Dmytro on 2/27/24.
//

import UIKit

public typealias CollectionViewReusableCell = UICollectionViewCell & Reusable

public extension UICollectionView {
    
    final func register<T>(cellType: T.Type) where T: CollectionViewReusableCell {
        self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T>(for indexPath: IndexPath,
                                      cellType: T.Type = T.self) -> T where T: CollectionViewReusableCell
    {
        let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, 
                                                for: indexPath)
        
        guard let cell = bareCell as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the cell beforehand"
            )
        }
        
        return cell
    }
    
    final func register<T>(supplementaryViewType: T.Type,
                           ofKind elementKind: String) where T: UICollectionReusableView, T: Reusable {
        register(supplementaryViewType.self,
                 forSupplementaryViewOfKind: elementKind,
                 withReuseIdentifier: supplementaryViewType.reuseIdentifier)
    }
    
    final func dequeueReusableSupplementaryView<T>(
        ofKind: String,
        for indexPath: IndexPath,
        viewType: T.Type = T.self) -> T where T: UICollectionReusableView, T: Reusable {
            
        let view = dequeueReusableSupplementaryView(ofKind: ofKind,
                                                    withReuseIdentifier: viewType.reuseIdentifier,
                                                    for: indexPath)
        
        guard let typedView = view as? T else {
            fatalError(
                "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
                + "matching type \(viewType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the supplementary view beforehand"
            )
        }
        
        return typedView
    }
}
