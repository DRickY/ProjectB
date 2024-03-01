//
//  SplashViewController.swift
//  ProjectB
//
//  Created by Dmytro on 2/26/24.
//

import UIKit

protocol SplashView: AnyObject {
    func update(progress: Float)
}

final class SplashViewController: UIViewController, SplashView {
    
    private static let progressBarHeight: CGFloat = 6
    
    private lazy var appBackground: UIImageView = makeImageView(.background)
    
    private lazy var appTitleImageView: UIImageView = makeImageView(.title)
    
    private lazy var appWelcomeImageView: UIImageView = makeImageView(.welcome)
    
    private let appProgressBar = UIProgressView(progressViewStyle: .default)

    private let heightView: UIView = UIView()
    
    var viewModel: ISplashViewModel?
    
    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.start()
    }

    private func prepareSubviews() {
        view.addSubviews([heightView, appBackground, appTitleImageView, appWelcomeImageView, appProgressBar])
        prepareProgressBar()
        prepareLayout()
    }
    
    private func prepareProgressBar() {
        appProgressBar.progressTintColor = .white
        appProgressBar.trackTintColor = .white.withAlphaComponent(0.6)
        appProgressBar.clipsToBounds = true
        appProgressBar.layer.cornerRadius = Self.progressBarHeight / 2
    }
    
    private func prepareLayout() {
        heightView.anchor(self.view.topAnchor,
                          leading: self.view.leadingAnchor,
                          trailing: self.view.trailingAnchor)

        heightView.multipliedHeight(self.view, multiplier: 0.33)
        
        appBackground.fillTo(superview: self.view)
        
        appTitleImageView.anchor(heightView.bottomAnchor, topConstraint: 0)
        appTitleImageView.anchorCenterX(superview: self.view)
        
        appWelcomeImageView.anchor(appTitleImageView.bottomAnchor, topConstraint: 19)
        appWelcomeImageView.anchorCenterX(superview: appTitleImageView)
        
        appProgressBar.anchor(appWelcomeImageView.bottomAnchor,
                              leading: self.view.leadingAnchor,
                              trailing: self.view.trailingAnchor,
                              topConstraint: 40,
                              leadingConstraint: 50,
                              trailingConstraint: 51,
                              heightConstraint: Self.progressBarHeight)
    }
    
    // MARK: SplashView
    
    func update(progress: Float) {
        appProgressBar.setProgress(progress, animated: true)
    }
    
    // MARK: Private
    
    private func makeImageView(_ image: SplashViewImage) -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = image.image

        return view
    }
}
