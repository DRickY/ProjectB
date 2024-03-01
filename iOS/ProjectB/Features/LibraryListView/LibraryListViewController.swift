//
//  ViewController.swift
//  ProjectB
//
//  Created by Dmytro on 2/26/24.
//

import UIKit

final class LibraryListViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = makeCollectionView

    var viewModel: ILibraryViewModel? = nil
    
    private var vm: ILibraryViewModel {
        guard let dataSource = self.viewModel else {
            fatalError("Please set viewModel `LibraryViewModel` protocol")
        }
        
        return dataSource
    }
    
    // MARK: View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareSubviews()
    }
    
    // MARK: Private

    private func prepareSubviews() {
        view.backgroundColor = Color.mainBackground
        view.addSubview(collectionView)
        prepareCollection()
        
        prepareLayout()
    }
    
    private func prepareCollection() {
        let collectionView = self.collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .always
        
        registerCells()
    }
    
    private func registerCells() {
        collectionView.register(cellType: LibraryViewCell.self)
        collectionView.register(cellType: BannerViewCell.self)
        collectionView.register(supplementaryViewType: LibraryHeaderView.self,
                                ofKind: CollectionSupplementaryView.header.rawValue)
    }

    private func prepareLayout() {
        collectionView.fillTo(superview: self.view)
    }
}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate

extension LibraryListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberOfItems(in: section)
    }
    
    func collectionView( _ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath, viewType: LibraryHeaderView.self)

        header.set(title: vm.genreTitle(for: indexPath))
        
        return header
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: BannerViewCell.self)
            cell.setDataSource(self)
            
            vm.setIndexChanged { [weak cell] page, shouldScroll in
                cell?.setNetPage(page, direction: .centeredHorizontally, shouldScroll: shouldScroll)
            }
            
            vm.prepareTimer()
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: LibraryViewCell.self)
            cell.set(model: vm.bookModel(at: indexPath), Color.whiteGray)
            return cell
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.section == 0, let banner = cell as? BannerViewCell {
//            vm.invalidateTimer()
//            banner.setDataSource(nil)
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        vm.didSelectItem(at: indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: BannerDataSource

extension LibraryListViewController: BannerDataSource {
    func registerView() -> CollectionViewReusableCell.Type {
        HorizontalViewItem.self
    }
    
    func pageIndicatorColors() -> (selected: UIColor, inactive: UIColor)? {
        return (Color.primaryPink, Color.lightGray2)
    }

    func bannerItems() -> Int {
        return vm.bannerItems()
    }
    
    func banner(_ collectionView: UICollectionView, itemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: HorizontalViewItem.self)
        cell.setModel(vm.bannerModel(at: indexPath))
        
        return cell
    }
        
    func banner(_ collectionView: UICollectionView, didSelectAt indexPath: IndexPath) {
        vm.bannerDidSelect(at: indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
        
    func bannerWillBeginDragging(_ banner: HorizontalBannerView) {
        vm.invalidateTimer()
    }

    func bannerDidEndAnyDragging(_ banner: HorizontalBannerView) {
        vm.prepareTimer()
    }
    
    func banner(_ banner: HorizontalBannerView, didMoveToDirection: HorizontalDirection) {
        vm.setNewPage(direction: didMoveToDirection)
    }
}

extension LibraryListViewController {
    fileprivate var makeCollectionView: UICollectionView {
        let layout = UICollectionViewCompositionalLayout { (section, _) in
            LibraryListSectionLayout(section: section).layout()
        }
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
}
