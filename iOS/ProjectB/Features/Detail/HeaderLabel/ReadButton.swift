//
//  ReadButton.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import UIKit


final class ReadNowButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }

    private func prepare() {
        backgroundColor = Color.lightPink
        titleLabel?.textColor = Color.white
        titleLabel?.font = .nunitoSansExtraBold(16)
        setTitle("Read Now", for: .normal)
    }
}

