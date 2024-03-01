//
//  SplashViewModel.swift
//  ProjectB
//
//  Created by Dmytro on 2/26/24.
//

import Foundation

protocol ISplashViewModel: AnyObject {
    func start()
}

final class SplashViewModel: ISplashViewModel {
    private var progress: Float = 0
    private let interval: TimeInterval = 0.05
    private var timer: Timer?
    private let duration: TimeInterval

    unowned var view: SplashView
    
    var signal: (() -> Void)?
    
    init(view: SplashView, duration: TimeInterval = 2) {
        self.view = view
        self.duration = duration
    }

    func start() {
        timer = Timer.scheduledTimer(timeInterval: interval,
                                     target: self,
                                     selector: #selector(updateProgress),
                                     userInfo: nil,
                                     repeats: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.complete()
        }
    }
    
    func complete() {
        timer?.invalidate()
        timer = nil
        signal?()
    }
    
    @objc private func updateProgress() {
        let step = Int(duration / interval)
        let newProgress = 1.0 / Float(step)

        progress += newProgress

        view.update(progress: progress)
    }
}
