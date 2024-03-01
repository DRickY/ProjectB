//
//  InfoCell.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import UIKit

final class InfoCell: UICollectionViewCell, Reusable {

    private let stackView = UIStackView()
    private let infoLabel = UILabel()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareSubviews()
        prepareLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
//  MARK: Public 

    func update(_ model: LibraryModel.Book.BookInfo) {
        titleLabel.text = model.title
        infoLabel.text = model.value
    }

//  MARK: Private

    private func prepareSubviews() {
        addSubview(stackView)
        [infoLabel, titleLabel].forEach(stackView.addArrangedSubview)
        
        prepareInfo()
        prepareTitle()
        prepareStackView()
    }
    
    private func prepareStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
    }

    private func prepareInfo() {
        infoLabel.font = .boldSystemFont(ofSize: 18)
        infoLabel.textColor = .black
        infoLabel.textAlignment = .center
    }

    private func prepareTitle() {
        titleLabel.font = .nunitoSansSemiBold(12)
        titleLabel.textColor = Color.lightGray2
        titleLabel.textAlignment = .center
    }

    private func prepareLayout() {
        stackView.fillTo(superview: self.contentView)
    }
}
