//
//  LibraryListSectionLayout.swift
//  ProjectB
//
//  Created by Dmytro on 2/26/24.
//

import UIKit

enum LibraryListSectionLayout {
    case banner
    case book
    
    init(section: Int) {
        switch section {
        case 0:
            self = .banner
        default:
            self = .book
        }
    }
}

enum CollectionSupplementaryView: String {
    case header = "books-header-kind"
}

extension LibraryListSectionLayout {

    func layout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(fractionalSize: 1)
        switch self {
        case .banner:
            return makeBannerLayout(item)
        case .book:
            item.contentInsets.leading = 8
            return makeBookLayout(item)
        }
    }
    
    private func makeBannerLayout(_ parent: NSCollectionLayoutItem) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
                
        let section = NSCollectionLayoutSection(group: .horizontal(layoutSize: size, subitems: [parent]))
        section.contentInsets.top = 20
        section.contentInsets.bottom = 40
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }

    private func makeBookLayout(_ parent: NSCollectionLayoutItem) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(120), heightDimension: .estimated(190))

        let section = NSCollectionLayoutSection(group: .horizontal(layoutSize: size, subitems: [parent]))
        section.contentInsets = .init(top: 14, leading: 8, bottom: 24, trailing: 16)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.boundarySupplementaryItems = [makeHeader(.header)]

        return section
    }
    
    private func makeHeader(_ key: CollectionSupplementaryView) -> NSCollectionLayoutBoundarySupplementaryItem {
        let layout = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(32))

        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layout,
            elementKind: key.rawValue,
            alignment: .top
        )
    }
}

