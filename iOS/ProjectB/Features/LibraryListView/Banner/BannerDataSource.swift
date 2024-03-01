//
//  BannerDataSource.swift
//  ProjectB
//
//  Created by Dmytro on 2/27/24.
//

import UIKit

enum HorizontalDirection {
    case leading
    case trailing
}

protocol BannerDataSource: AnyObject {
    
    func registerView() -> CollectionViewReusableCell.Type
        
    func bannerItems() -> Int
    
    func banner(_ collectionView: UICollectionView, itemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func pageIndicatorColors() -> (selected: UIColor, inactive: UIColor)?

    func bannerDidEndScrollDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    
    func bannerWillEndScrollDragging(_ view: HorizontalBannerView, velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>, indexPage: Int, naturalPage: Int)
    
    func banner(_ collectionView: UICollectionView, didSelectAt indexPath: IndexPath)
    
    func banner(_ banner: HorizontalBannerView, pageDidChange page: Int)
    
    func bannerWillBeginDragging(_ banner: HorizontalBannerView)

    func bannerDidEndAnyDragging(_ banner: HorizontalBannerView)
    
    func banner(_ banner: HorizontalBannerView, didMoveToDirection: HorizontalDirection)
}

extension BannerDataSource {
    func pageIndicatorColors() -> (selected: UIColor, inactive: UIColor)? { nil }

    func bannerDidEndScrollDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {}
    
    func bannerWillEndScrollDragging(_ view: HorizontalBannerView, velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>, indexPage: Int, naturalPage: Int) {}
    
    func banner(_ collectionView: UICollectionView, didSelectAt indexPath: IndexPath) {}
    
    func banner(_ banner: HorizontalBannerView, pageDidChange page: Int) {}
    
    func bannerWillBeginDragging(_ banner: HorizontalBannerView) {}

    func bannerDidEndAnyDragging(_ banner: HorizontalBannerView) {}
    
    func banner(_ banner: HorizontalBannerView, didMoveToDirection: HorizontalDirection) {}
}
