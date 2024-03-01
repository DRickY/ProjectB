//
//  Reusable.swift
//  ProjectB
//
//  Created by Dmytro on 2/27/24.
//

import UIKit

public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

