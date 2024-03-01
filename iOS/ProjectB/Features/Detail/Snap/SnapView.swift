//
//  SnapView.swift
//  ProjectB
//
//  Created by Dmytro on 2/28/24.
//

import UIKit

final class SnapView: UIView {
    
    private var makeCollection: UICollectionView {
        let layout = SnappingLayout()
        let size = CGSize(width: 160, height: 200)
        layout.itemSize = size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 70
        layout.minimumInteritemSpacing = 0
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }

    private let backgroundImageView: UIImageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private lazy var collectionView: UICollectionView = makeCollection
    
    private var source: SnapViewDataSource {
        guard let dataSource = self.snapDataSource else {
            fatalError("Please implement `SnapViewDataSource` protocol")
        }
        
        return dataSource
    }

    weak var snapDataSource: SnapViewDataSource?

    // MARK: Public
    
    public func prepare() {
        prepareSubviews()
        prepareLayout()
    }
    
    public func updateContent(title: String, author: String) {
        titleLabel.text = title
        authorLabel.text = author
    }

    // MARK: Private
    
    private func prepareSubviews() {
        addSubviews([backgroundImageView, collectionView, titleLabel, authorLabel])

        prepareImageView()
        prepareCollectionView()
        prepareTitle()
        prepareAuthor()
    }
    
    private func prepareCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: source.registerView())
    }

    private func prepareImageView() {
        backgroundImageView.image = UIImage(resource: .detailBackground)
    }

    private func prepareTitle() {
        titleLabel.textColor = Color.white
        titleLabel.font = .boldSystemFont(ofSize: 20)
    }

    private func prepareAuthor() {
        authorLabel.textColor = Color.whiteGray
        authorLabel.font = .nunitoSansBold(14)
    }
    
    private func prepareLayout() {
        backgroundImageView.fillTo(superview: self)
        
        collectionView.anchor(topAnchor,
                              leading: leadingAnchor,
                              trailing: trailingAnchor,
                              topConstraint: 80, heightConstraint: 280)

        titleLabel.anchor(collectionView.bottomAnchor, topConstraint: 16)
        titleLabel.anchorCenterX(superview: self)

        authorLabel.anchor(titleLabel.bottomAnchor, topConstraint: 4)
        authorLabel.anchorCenterX(superview: self)
        authorLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
                                            constant: -16).isActive = true
    }
}

extension SnapView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.snapViewItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return source.snapView(collectionView, itemAt: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = CGPoint(x: collectionView.center.x + collectionView.contentOffset.x,
                             y: collectionView.center.y + collectionView.contentOffset.y)
        if let indexPath = collectionView.indexPathForItem(at: center) {
            source.snapViewDidChange(at: indexPath)
        }
    }
}
