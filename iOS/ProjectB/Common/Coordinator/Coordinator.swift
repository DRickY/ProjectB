//
//  Coordinator.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import UIKit

 public protocol Coordinator: AnyObject {
    func start()
    func start(_ completion: (() -> Void)?)
}

public extension Coordinator {
    func start(_ completion: (() -> Void)?) {
        start()
    }
    
    func start() {}
}
