//
//  DetailBookViewModel.swift
//  ProjectB
//
//  Created by Dmytro on 3/1/24.
//

import Foundation

protocol IDetailBookViewModel {
    
    func loaded()
    
    func alsoLikeBooks() -> [LibraryModel.Book]
    
    func snapItems() -> Int

    func snapModel(at indexPath: IndexPath) -> LibraryModel.Book
    
    func snapDidChange(indexPath: IndexPath)
}

final class DetailBookViewModel: IDetailBookViewModel {
    private var chosenBook: LibraryModel.Book?
    private let books: [LibraryModel.Book]
    private let alsoLike: [LibraryModel.Book]
    unowned var view: DetailBookView
    
    init(view: DetailBookView, chosenBook: LibraryModel.Book?, books: [LibraryModel.Book], alsoLike: [LibraryModel.Book]) {
        self.books = books
        self.alsoLike = alsoLike
        self.chosenBook = chosenBook ?? books.first
        self.view = view
    }
}

extension DetailBookViewModel {
    func loaded() {
        if let chosenBook {
            view.updateContent(book: chosenBook)
        }
    }
    
    func alsoLikeBooks() -> [LibraryModel.Book] {
        return alsoLike
    }
    
    func snapItems() -> Int {
       return books.count
    }

    func snapModel(at indexPath: IndexPath) -> LibraryModel.Book {
        return books[indexPath.item]
    }

    func snapDidChange(indexPath: IndexPath) {
        let snappedBook = books[indexPath.item]
        
        if snappedBook.id != chosenBook?.id {
            chosenBook = snappedBook
            view.updateContent(book: snappedBook)
        }
    }
}
