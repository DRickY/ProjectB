//
//  SplashViewController+Image.swift
//  ProjectB
//
//  Created by Dmytro on 2/26/24.
//

import UIKit

extension SplashViewController {
    enum SplashViewImage {
        case background
        case title
        case welcome
        
        var image: UIImage? {
            switch self {
            case .background:
                return .init(named: "lauch_background")
            case .title:
                return .init(named: "book_app_title")
            case .welcome:
                return .init(named: "welcome_book_app")
            }
        }
    }
}
