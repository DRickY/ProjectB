//
//  Test.swift
//  ProjectB
//
//  Created by Dmytro on 2/27/24.
//

import UIKit

final class BannerViewCell: UICollectionViewCell, Reusable {

    private lazy var horizontalView = HorizontalBannerView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareSubviews()
        prepareLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private

    private func prepareSubviews() {
        addSubview(horizontalView)
    }
    
    private func prepareLayout() {
        horizontalView.fillTo(superview: self)
    }
    
    // MARK: Public

    public func setDataSource(_ dataSource: BannerDataSource?) {
        horizontalView.bannerDataSource = dataSource
    }
    
    public func setNetPage(_ page: Int, direction: UICollectionView.ScrollPosition = [], shouldScroll: Bool) {
        horizontalView.setNew(page: page, 
                              direction: direction,
                              shouldScroll: shouldScroll)
    }
}
