//
//  LibraryCoordinator.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import UIKit

public final class LibraryCoordinator: Coordinator {
    private var presenter: UINavigationController?
    private var model: LibraryModel
    
    init(presenter: UINavigationController, model: LibraryModel) {
        self.presenter = presenter
        self.model = model
    }
    
    public func start() {
        let vc = LibraryListViewController()
        let viewModel = LibraryViewModel(model: model)
        vc.viewModel = viewModel
        
        viewModel.openDetail = { [weak self] (chosenBook, books, alsoLike) in
            self?.openDetail(chosenBook: chosenBook, books: books, alsoLike: alsoLike)
        }
        
        presenter?.viewControllers = [vc]
        
        vc.navigationItem.leftBarButtonItem = leftBarItem()
        prepareNavigationBar()
    }
    
    // MARK: Private
    
    private func leftBarItem() -> UIBarButtonItem {
        let label = UILabel()
        label.textColor = Color.primaryPink
        label.font = .nunitoSansBold(20)
        label.textAlignment = .left
        label.text = "Library"

        return UIBarButtonItem(customView: label)
    }
    
    private func prepareNavigationBar() {
        if let navigationBar = presenter?.navigationBar {
            let image = UIImage()
            navigationBar.setBackgroundImage(image, for: .default)
            navigationBar.shadowImage = image
            navigationBar.barTintColor = .clear
            navigationBar.tintColor = .white
        }
    }
    
    private func backButton() -> UIBarButtonItem {
        let arrowImage = UIImage(resource: .backArrow)
        let button = UIButton(type: .system)
        button.setImage(arrowImage, for: [])
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }

    func openDetail(chosenBook: LibraryModel.Book?, books: [LibraryModel.Book], alsoLike: [LibraryModel.Book]) {
        let detailVc = DetailBookViewController()
        let viewModel = DetailBookViewModel(view: detailVc,
                                            chosenBook: chosenBook,
                                            books: books,
                                            alsoLike: alsoLike)
        detailVc.viewModel = viewModel
        
        detailVc.navigationItem.leftBarButtonItem = backButton()

        presenter?.pushViewController(detailVc, animated: true)
    }
    
    @objc
    private func backAction() {
        presenter?.popViewController(animated: true)
    }
}
