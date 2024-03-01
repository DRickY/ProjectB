//
//  BannerCell.swift
//  ProjectB
//
//  Created by Dmytro on 2/27/24.
//

import UIKit
import Kingfisher

final class HorizontalViewItem: UICollectionViewCell, Reusable {
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
        prepareLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func setModel(_ model: LibraryModel.Banner) {
        imageView.kf.setImage(with: model.url,
                              placeholder: UIImage.placeholderImage,
                              options: [.cacheMemoryOnly])
    }
    
    // MARK: - Private

    private func prepareSubviews() {
        addSubview(imageView)

        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
    }

    private func prepareLayout() {
        imageView.anchor(topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         leadingConstraint: 8,
                         trailingConstraint: 8)
    }
}
