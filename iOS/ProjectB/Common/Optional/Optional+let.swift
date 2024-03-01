//
//  Optional+let.swift
//  ProjectB
//
//  Created by Dmytro on 2/27/24.
//

import Foundation

public extension Optional {
    var isLet: Bool {
        return self != nil
    }
}
