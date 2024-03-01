//
//  SnapCell.swift
//  ProjectB
//
//  Created by Dmytro on 2/28/24.
//

import UIKit

final class SnapCell: UICollectionViewCell, Reusable {
    private let imageView: UIImageView = .init()

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

    func prepareSubviews() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true

        contentView.addSubview(imageView)
    }
    
    func prepareLayout() {
        imageView.fillTo(superview: self.contentView)
    }

    public func prepareDisplay(model: LibraryModel.Book) {
        imageView.kf.setImage(with: model.url,
                              placeholder: UIImage.placeholderImage,
                              options: [.cacheMemoryOnly])
    }
}
