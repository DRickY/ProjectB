//
//  SplashCoordinator.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import UIKit

final class SplashCoordinator: Coordinator {
    private var viewController: UIViewController?
    private var presenter: UIViewController
    
    init(presenter: UIViewController) {
        self.presenter = presenter
    }
    
    func start(_ completion: (() -> Void)?) {
        let view = SplashViewController()
        let viewModel = SplashViewModel(view: view, duration: 2)
        view.viewModel = viewModel

        viewModel.signal = { [weak self] in
            completion?()
            self?.viewController = nil
        }
        
        if let nav = presenter as? UINavigationController {
            nav.setViewControllers([view], animated: false)
        }
    }
}
