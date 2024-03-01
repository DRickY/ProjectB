//
//  HorizontalBannerView.swift
//  ProjectB
//
//  Created by Dmytro on 2/27/24.
//

import UIKit

class HorizontalBannerView: UIView {
    
    // MARK: - UI Properties

    private var makeView: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        
        return .init(frame: .zero, collectionViewLayout: layout)
    }
    
    private var source: BannerDataSource {
        guard let dataSource = self.bannerDataSource else {
            fatalError("Please implement `BannerDataSource` protocol")
        }
        
        return dataSource
    }
    
    private lazy var collectionView: UICollectionView = makeView
    private var pageControl: UIPageControl = UIPageControl()
    
    // MARK: - Properties
    
    weak var bannerDataSource: BannerDataSource? {
        willSet {
            if !newValue.isLet { prepareForReuse() }
        }
        
        didSet {
            if bannerDataSource.isLet { prepare() }
        }
    }
    
    private var currentPage: Int {
        pageControl.currentPage
    }
    
    private var startPositionContentOffset: CGPoint?
        
    // MARK: - Private

    private func prepare() {
        prepareSubviews()
        prepareLayout()
    }
    
    private func prepareForReuse() {
        [collectionView, pageControl].forEach { $0.removeFromSuperview() }
    }
    
    private func prepareSubviews() {
        addSubviews([collectionView, pageControl])
        
        prepareCollectionView()
        preparePageControl()
    }
    
    private func prepareLayout() {
        collectionView.fillTo(superview: self)
        
        pageControl.anchorCenterX(superview: self)
        pageControl.anchor(bottom: collectionView.bottomAnchor,
                           bottomConstraint: 15,
                           heightConstraint: 22)
    }
    
    private func prepareCollectionView() {
        collectionView.register(cellType: source.registerView())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func preparePageControl() {
        let (selected, inactive) = source.pageIndicatorColors() ?? defaultPageColors()
        
        pageControl.pageIndicatorTintColor = inactive
        pageControl.currentPageIndicatorTintColor = selected
        pageControl.isUserInteractionEnabled = false
        pageControl.allowsContinuousInteraction = false

        pageControl.numberOfPages = source.bannerItems()
        setNew(page: .zero, shouldScroll: true)
    }
    
    private func defaultPageColors() -> (selected: UIColor, inactive: UIColor) {
        return (selected: .blue, inactive: .gray)
    }
    
    private func setPage(page: Int) {
        pageControl.currentPage = page
    }
    
    // MARK: - Public
    
    public func setNew(page: Int, direction: UICollectionView.ScrollPosition = [], shouldScroll: Bool) {
        collectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: direction, animated: true)
        setPage(page: page)
        source.banner(self, pageDidChange: page)
    }
}

extension HorizontalBannerView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.bannerItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return source.banner(collectionView, itemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        source.banner(collectionView, didSelectAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

extension HorizontalBannerView: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let current = currentPage
        let indexPage = Int(targetContentOffset.pointee.x / bounds.width)
        let naturalPage = indexPage + 1

        guard  current != indexPage else { return }

        source.bannerWillEndScrollDragging(self,
                                           velocity: velocity,
                                           targetContentOffset: targetContentOffset,
                                           indexPage: indexPage, naturalPage: naturalPage)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        source.bannerDidEndScrollDragging(scrollView, willDecelerate: decelerate)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        source.bannerWillBeginDragging(self)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        source.bannerDidEndAnyDragging(self)
    }
}
