//
//  LineView.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import UIKit

final class LineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepereSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func prepereSubviews() {
        backgroundColor = Color.lightGray
        anchor(heightConstraint: 1)
    }
}

