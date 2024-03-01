//
//  DetailBookViewController.swift
//  ProjectB
//
//  Created by Dmytro on 2/28/24.
//

import UIKit

protocol DetailBookView: AnyObject {
    func updateContent(book: LibraryModel.Book)
}

final class DetailBookViewController: UIViewController, DetailBookView {
    private let snapView = SnapView()
    private let detailedInfo = DetailedInfoView()
    private let summaryView = SummaryView()
    private let recomendView = RecomendationView()
    private let readNow = ReadNowButton()

    private let contentView = UIView()
    private let scrollView = UIScrollView()

    var viewModel: IDetailBookViewModel?
    
    private var vm: IDetailBookViewModel {
        guard let dataSource = self.viewModel else {
            fatalError("Please set viewModel `IDetailBookViewModel` protocol")
        }
        
        return dataSource
    }
    
    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        prepareSubviews()
        prepareLayout()
        
        recomendView.prepare(data: vm.alsoLikeBooks())
        
        vm.loaded()
    }
    
    func updateContent(book: LibraryModel.Book) {
        snapView.updateContent(title: book.name, author: book.author)
        detailedInfo.prepare(data: book.bookInfo)
        summaryView.prepare(content: book.summary)
    }
    
    // MARK: Private

    private func prepareSubviews() {
        prepareScrollView()
        prepareSnapView()
        
        contentView.addSubviews([detailedInfo, summaryView, recomendView, readNow])
    }
    
    private func prepareScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
    }
    
    private func prepareSnapView() {
        contentView.addSubview(snapView)
        
        snapView.snapDataSource = self
        snapView.prepare()
    }
    
    private func prepareLayout() {
        scrollView.anchor(view.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor)
  
        contentView.anchor(scrollView.topAnchor,
                           leading: scrollView.leadingAnchor,
                           bottom: scrollView.bottomAnchor)
        contentView.anchorWidth(scrollView)
        
        snapView.anchor(contentView.topAnchor,
                        leading: contentView.leadingAnchor,
                        trailing: contentView.trailingAnchor,
                        heightConstraint: 460)
        
        detailedInfo.anchor(snapView.bottomAnchor,
                            leading: snapView.leadingAnchor,
                            trailing: snapView.trailingAnchor,
                            topConstraint: -20)

        summaryView.anchor(detailedInfo.bottomAnchor,
                           leading: snapView.leadingAnchor,
                           trailing: snapView.trailingAnchor,
                           topConstraint: 10,
                           leadingConstraint: 16,
                           trailingConstraint: 16)

        recomendView.anchor(summaryView.bottomAnchor,
                            leading: snapView.leadingAnchor,
                            trailing: snapView.trailingAnchor,
                            topConstraint: 16,
                            leadingConstraint: 16,
                            trailingConstraint: 16)

        readNow.anchor(recomendView.bottomAnchor,
                       leading: contentView.leadingAnchor,
                       bottom: contentView.bottomAnchor,
                       trailing: contentView.trailingAnchor,
                       topConstraint: 24, leadingConstraint: 48,
                       bottomConstraint: 64,
                       trailingConstraint: 48,
                       heightConstraint: 50)
    }
}

//    MARK: UIScrollViewDelegate
extension DetailBookViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= .zero {
            scrollView.contentOffset.y = .zero
        }
    }
}

//    MARK: SnapViewDataSource
extension DetailBookViewController: SnapViewDataSource {

    func registerView() -> CollectionViewReusableCell.Type { SnapCell.self }
    
    func snapViewItems() -> Int {
        return vm.snapItems()
    }
    
    func snapView(_ collectionView: UICollectionView, itemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SnapCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.prepareDisplay(model: vm.snapModel(at: indexPath))
        
        return cell
    }
    
    func snapViewDidChange(at indexPath: IndexPath) {
        vm.snapDidChange(indexPath: indexPath)
    }
}
