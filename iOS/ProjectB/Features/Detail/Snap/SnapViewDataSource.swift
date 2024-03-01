//
//  SnapViewDataSource.swift
//  ProjectB
//
//  Created by Dmytro on 2/28/24.
//

import UIKit

protocol SnapViewDataSource: AnyObject {
    
    func registerView() -> CollectionViewReusableCell.Type
    
    func snapViewItems() -> Int
    
    func snapView(_ collectionView: UICollectionView, itemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func snapViewDidChange(at indexPath: IndexPath)
}

