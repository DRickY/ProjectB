//
//  UIColor.swift
//  ProjectB
//
//  Created by Dmytro on 2/27/24.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1) {
        assert(hex[hex.startIndex] == "#", "Expected hex string of format #RRGGBB")
        
        let scanner = Scanner(string: hex)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#") // skip #
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0xFF00) >> 8) / 255.0,
            blue: CGFloat((rgb & 0xFF)) / 255.0,
            alpha: alpha)
    }
    
    func hex() -> String {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return String(format: "%02X%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255), Int(alpha * 255))
    }
}

enum Color {
    static var white = UIColor.white
    static var whiteGray = UIColor.white.withAlphaComponent(0.7)
    static var lightGray = UIColor(hex: "#D9D5D6")
    static var headerText = UIColor(hex: "#0B080F")
    static var regularText = UIColor(hex: "#393637")
    static var primaryPink = UIColor(hex: "#D0006E")
    static var lightPink = UIColor(hex: "#DD48A1")
    static var lightGray2 = UIColor(hex: "#C1C2CA") // dot color
    static var background = UIColor(hex: "#532454")
    static var mainBackground = UIColor(hex: "#101010")
}

