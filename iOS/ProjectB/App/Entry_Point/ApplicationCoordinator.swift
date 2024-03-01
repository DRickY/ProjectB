//
//  ApplicationCoordinator.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import UIKit
import Combine

final class ApplicationCoordinator: Coordinator {
    private var libraryCoordinator: LibraryCoordinator?
    private var splashCoordinator: SplashCoordinator?
    
    private let navigationController = UINavigationController()

    private let window: UIWindow?
    
    @Inject
    private var libraryRepository: LibraryRepository
    
    private var canaclable: AnyCancellable?
    private var model: LibraryModel?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        canaclable = libraryRepository.books()
            .sink(receiveCompletion: { completion in
//            TODO: handle error
                debugPrint("DEBUG: Error: \(completion)")
            }, receiveValue: {[weak self] in
                self?.model = $0
            })
        
        
        startSplashCoordinator()
    }

    func startSplashCoordinator() {
        let coordinator = SplashCoordinator(presenter: navigationController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        navigationController.setNavigationBarHidden(true, animated: false)

        coordinator.start { [weak self] in
            self?.startLibraryCoordinator()
            self?.splashCoordinator = nil
            self?.canaclable?.cancel()
            self?.canaclable = nil
        }

        splashCoordinator = coordinator
    }

    func startLibraryCoordinator() {
        guard let model = model else {
            debugPrint("Debug: Model is not loaded")
            // TODO: show alert?
            return
        }
        let coordinator = LibraryCoordinator(presenter: navigationController, model: model)
        coordinator.start()
        navigationController.setNavigationBarHidden(false, animated: false)

        libraryCoordinator = coordinator
    }
}

