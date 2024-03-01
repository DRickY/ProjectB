//
//  LibraryViewModel.swift
//  ProjectB
//
//  Created by Dmytro on 2/27/24.
//

import Foundation

protocol ILibraryViewModel {
    func setIndexChanged(_ handler: ((Int, Bool) -> Void)?)
    
    func prepareTimer()
    func invalidateTimer()
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func genreTitle(for indexPath: IndexPath) -> String
    func bookModel(at indexPath: IndexPath) -> LibraryModel.Book
    func didSelectItem(at indexPath: IndexPath)
    
    func bannerItems() -> Int
    func bannerModel(at indexPath: IndexPath) -> LibraryModel.Banner
    func bannerDidSelect(at indexPath: IndexPath)
    
    func setNewPage(direction: HorizontalDirection)
}

final class LibraryViewModel: ILibraryViewModel {
    private var defaultBannerInterval: TimeInterval = 3.0
    private var timer: Timer?
    private var bannerPage: Int = 0
    private let model: LibraryModel
    
    private var indexChanged: ((Int, Bool) -> Void)?
    
    var openDetail: ((_ chosenBook: LibraryModel.Book?, _ books: [LibraryModel.Book], _ recomenration: [LibraryModel.Book]) -> Void)?
    
    init(model: LibraryModel) {
        self.model = model
    }
    
    // MARK: Actions
    
    @objc
    private func timerAction() {
        setNewPage(direction: .leading)
    }
    
    // MARK: Private
    
    private func manualSwipeAction() {
//        guard let maxCount = bannerItems.indices.max() else { return }
//        let appendValue = direction == .leading ? 1 : -1
//        
//        var newPage: Int
//        if oldPage == 0 {
//            newPage = direction == .leading ? oldPage + 1 : maxCount
//        } else if oldPage == maxCount {
//            newPage = direction == .leading ? 0 : oldPage - 1
//        } else {
//            newPage = oldPage + appendValue
//        }
//        bannerPage = newPage
//        indexChanged?(bannerPage, true)
    }
    
    private func autoSwipeAction() {
        let bannerItems = bannerItems()
        let oldPage = bannerPage
        var newPage = oldPage + 1
        
        if newPage >= bannerItems {
            newPage = newPage % bannerItems
        }
        
        bannerPage = newPage
        indexChanged?(bannerPage, true)
    }
}

extension LibraryViewModel {
    public func setIndexChanged(_ handler: ((Int, Bool) -> Void)?) {
        self.indexChanged = handler
    }
    
    public func prepareTimer() {
        guard !model.banner.isEmpty, timer == nil else { return }
        let timer = Timer.scheduledTimer(timeInterval: defaultBannerInterval,
                                         target: self,
                                         selector: #selector(timerAction),
                                         userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer, forMode: .common)
        
        self.timer = timer
    }
    
    public func invalidateTimer() {
        if let t = timer {
            t.invalidate()
            timer = nil
        }
    }
    
    public func numberOfSections() -> Int {
        let bannerSection = model.banner.isEmpty ? 0 : 1
        
        return bannerSection + model.genres.count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        if section == 0 {
            return model.banner.isEmpty ? 0 : 1
        } else {
            let genre = model.genres[section - 1]
            return genre.books.count
        }
    }
    
    public func genreTitle(for indexPath: IndexPath) -> String {
        let genre = model.genres[indexPath.section - 1]
        
        return genre.genre
    }
    
    public func bookModel(at indexPath: IndexPath) -> LibraryModel.Book {
        let genre = model.genres[indexPath.section - 1]
        return genre.books[indexPath.item]
    }
    
    public func didSelectItem(at indexPath: IndexPath) {
        let genre = model.genres[indexPath.section - 1]
        let chosenBook = genre.books[indexPath.item]
        let books = makeSelectedBookFirst(items: genre.books, chosenBook.id)
    
        openDetail?(chosenBook, books, model.youWillAlsoLikeBooks)
    }
    
    // MARK: Banner Section
    
    public func bannerItems() -> Int {
        model.banner.count
    }
    
    public func bannerModel(at indexPath: IndexPath) -> LibraryModel.Banner {
        return model.banner[indexPath.item]
    }
    
    public func bannerDidSelect(at indexPath: IndexPath) {
        let banner = model.banner[indexPath.item]
        
        if let genre = model.genres.first(where: { $0.contains(banner.bookId) }) {
            let books = makeSelectedBookFirst(items: genre.books, banner.bookId)
            let chosenBook = books.first(where: { $0.id ==  banner.bookId })
            openDetail?(chosenBook, books, model.youWillAlsoLikeBooks)
        }
    }
        
    public func setNewPage(direction: HorizontalDirection) {
        if timer != nil {
            autoSwipeAction()
        } else {
            manualSwipeAction()
        }
    }
    
    private func makeSelectedBookFirst(items: [LibraryModel.Book],
                                       _ selected: Int) -> [LibraryModel.Book] {
        var books = items
        
        if let index = books.firstIndex(where: { $0.id == selected }) {
            let book = books.remove(at: index)
            books.insert(book, at: 0)
        }
        
        return books
    }
}

extension LibraryModel.Genre {
    func contains(_ id: Int) -> Bool {
        return books.contains(where: { $0.id == id })
    }
}
