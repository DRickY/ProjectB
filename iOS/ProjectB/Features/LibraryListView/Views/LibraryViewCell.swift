//
//  LibraryViewCell.swift
//  ProjectB
//
//  Created by Dmytro on 2/26/24.
//

import UIKit
import Kingfisher

final class LibraryViewCell: UICollectionViewCell, Reusable {
    
    private let titleLabel: UILabel = UILabel()
    
    private let imageView: UIImageView = UIImageView()
    
    // MARK: Init & deinit
    
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
        titleLabel.text = ""
    }
    
    // MARK: Public
    
    func set(model: LibraryModel.Book, _ color: UIColor) {
        imageView.kf.setImage(with: model.url,
                              placeholder: UIImage.placeholderImage,
                              options: [.cacheMemoryOnly])
        
        titleLabel.textColor = color
        titleLabel.text = model.name
    }
    
    // MARK: Private
    
    private func prepareSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        prepareLabel()
        prepareImageView()
    }
    
    private func prepareLabel() {
        titleLabel.font = .nunitoSansSemiBold(16)
        titleLabel.numberOfLines = 0
    }
    
    private func prepareImageView() {
        imageView.backgroundColor = Color.lightGray
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
    }
    
    private func prepareLayout() {
        imageView.anchor(topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        imageView.proportional(multiplier: 1.22)
        
        titleLabel.anchor(imageView.bottomAnchor,
                          leading: leadingAnchor,
                          trailing: trailingAnchor,
                          topConstraint: 4)
    }
}
