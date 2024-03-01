//
//  LargeLabel.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import UIKit

public func largeHeaderLabel(_ color: UIColor) -> UILabel {
    let label = UILabel()
    label.font = .nunitoSansBold(20)
    label.textColor = color
    return label
}
