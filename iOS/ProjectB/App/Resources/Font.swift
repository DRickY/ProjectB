//
//  Font.swift
//  ProjectB
//
//  Created by Dmytro on 2/27/24.
//

import UIKit

extension UIFont {
    static func nunitoSansBold(_ size: CGFloat) -> UIFont {
        return .init(name: "NunitoSans_Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func nunitoSansSemiBold(_ size: CGFloat) -> UIFont {
        return .init(name: "NunitoSans_SemiBold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func nunitoSansExtraBold(_ size: CGFloat) -> UIFont {
        return .init(name: "NunitoSans_ExtraBold", size: size) ?? .systemFont(ofSize: size)
    }
}
