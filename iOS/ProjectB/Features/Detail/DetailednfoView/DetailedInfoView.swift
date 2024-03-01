//
//  DetailedInfoView.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import UIKit

final class DetailedInfoView: UIView {
    
    private let edgeCornersView = UIView()

    private var makeCollection: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let size = CGSize(width: 45, height: 35)
        layout.itemSize = size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 0, left: 38, bottom: 0, right: 29)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    private lazy var collectionView: UICollectionView = makeCollection

    private var data: [LibraryModel.Book.BookInfo] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareSubviews()
        prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: Public

    public func prepare(data: [LibraryModel.Book.BookInfo]) {
        self.data = data
        collectionView.reloadData()
    }
    
    //  MARK: Private

    private func prepareSubviews() {
        addSubviews([edgeCornersView, collectionView])
        prepareCollectionView()
        prepareCornerView()
    }
    
    private func prepareCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(cellType: InfoCell.self)
    }
        
    private func prepareCornerView() {
        edgeCornersView.backgroundColor = Color.white
        edgeCornersView.clipsToBounds = true
        edgeCornersView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        edgeCornersView.layer.cornerRadius = 10
    }
    
    private func prepareLayout() {
        edgeCornersView.anchor(topAnchor,
                              leading: leadingAnchor,
                              trailing: trailingAnchor,
                              heightConstraint: 20)
        
        collectionView.anchor(edgeCornersView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, heightConstraint: 35)
    }
}

extension DetailedInfoView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: InfoCell.self)
        cell.update(data[indexPath.item])
        
        return cell
    }
}
