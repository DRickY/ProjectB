//
//  LibraryHeaderView.swift
//  ProjectB
//
//  Created by Dmytro on 2/26/24.
//

import UIKit

final class LibraryHeaderView: UICollectionReusableView, Reusable {

    private let titleLabel = UILabel()

    // MARK: Init & deinit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareSubviews()
        prepareLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public

    public func set(title: String) {
        titleLabel.text = title
    }
    
    // MARK: Private

    private func prepareSubviews() {
        addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = .nunitoSansBold(20)
    }

    private func prepareLayout() {
        titleLabel.fillTo(superview: self)
    }
}
