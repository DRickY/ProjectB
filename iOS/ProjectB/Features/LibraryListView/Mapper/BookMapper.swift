//
//  BookMapper.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import Combine
import Foundation

struct BookMapper: Mapper {
    func map(from object: BookModelDTO) throws -> LibraryModel {
        let books = object.books.map {
            LibraryModel.Book(dto: $0)
        }
        
        let alsoLike = books.filter { object.youWillLikeSection.contains($0.id) }
        
        let byGenres = Dictionary(grouping: books) { $0.genre }
        let genres = byGenres.map {
            LibraryModel.Genre(genre: $0.key, books: $0.value)
        }
        
        let banner = object.topBannerSlides.map {
            LibraryModel.Banner(id: $0.id,
                                bookId: $0.bookId,
                                url: .init(string: $0.cover))
        }
        
        return LibraryModel(banner: banner,
                            genres: genres,
                            youWillAlsoLikeBooks: alsoLike)
    }
}

extension LibraryModel.Book {
    init(dto: BookModelDTO.Book) {
        self.init(id: dto.id,
                  name: dto.name,
                  author: dto.author,
                  summary: dto.summary,
                  url: .init(string: dto.coverUrl),
                  genre: dto.genre,
                  bookInfo: [
                    .init(value: dto.views, title: "Readers"),
                    .init(value: dto.likes, title: "Likes"),
                    .init(value: dto.quotes, title: "Quotes"),
                    .init(value: dto.genre, title: "Genre")]
        )
    }
}
