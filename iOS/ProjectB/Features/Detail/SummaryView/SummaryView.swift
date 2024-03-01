//
//  SummaryView.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import UIKit

final class SummaryView: UIView {
    
    private let line = LineView()
    private let vStack: UIStackView = UIStackView()
    private let largeLabel: UILabel = largeHeaderLabel(Color.headerText)
    private let contentLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareSubviews()
        prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    
    func prepare(content: String) {
        contentLabel.text = content
    }
    
    // MARK: Private
    
    private func prepareSubviews() {
        addSubviews([line, vStack])
        [largeLabel, contentLabel].forEach(vStack.addArrangedSubview)

        prepareVStack()
        prepareLargeView()
        prepareContent()
    }
        
    private func prepareVStack() {
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.distribution = .fill
    }

    private func prepareLargeView() {
        largeLabel.text = "Summary"
    }
    
    private func prepareContent() {
        contentLabel.font = .nunitoSansSemiBold(14)
        contentLabel.textColor = Color.regularText
        contentLabel.numberOfLines = 0
    }

    private func prepareLayout() {
        line.anchor(topAnchor, 
                    leading: leadingAnchor,
                    trailing: trailingAnchor)
        
        vStack.anchor(line.bottomAnchor, 
                      leading: leadingAnchor,
                      bottom: bottomAnchor,
                      trailing: trailingAnchor,
                      topConstraint: 16)
    }
}
