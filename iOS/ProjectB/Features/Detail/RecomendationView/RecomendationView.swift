//
//  RecomendationView.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import UIKit

final class RecomendationView: UIView {
    private var makeCollectionView: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 190)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8

        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }

    private let line = LineView()
    private let largeLabel: UILabel = largeHeaderLabel(Color.headerText)
    private lazy var collectionView: UICollectionView = makeCollectionView

    private var data: [LibraryModel.Book] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareSubviews()
        prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    
    public func prepare(data: [LibraryModel.Book]) {
        self.data = data
        collectionView.reloadData()
    }

    // MARK: Private
    
    private func prepareSubviews() {
        addSubviews([line, largeLabel, collectionView])

        prepareLargeView()
        prepareContent()
    }
        

    private func prepareLargeView() {
        largeLabel.text = "You will also like"
    }
    
    private func prepareContent() {
        let collectionView = self.collectionView
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cellType: LibraryViewCell.self)
    }

    private func prepareLayout() {
        line.anchor(topAnchor,
                    leading: leadingAnchor,
                    trailing: trailingAnchor)
        
        largeLabel.anchor(line.bottomAnchor,
                          leading: leadingAnchor,
                          trailing: trailingAnchor,
                          topConstraint: 16)
        
        collectionView.anchor(largeLabel.bottomAnchor,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor,
                              topConstraint: 16,
                              heightConstraint: 200)
    }
}

extension RecomendationView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: LibraryViewCell.self)
        let model = data[indexPath.item]
        cell.set(model: model, Color.regularText)
        return cell
    }
}
