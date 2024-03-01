//
//  LibraryListData.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import Foundation

struct LibraryModel {
    let banner: [Banner]
    let genres: [Genre]
    let youWillAlsoLikeBooks: [Book]
    
    struct Book {
        public let id: Int
        public let name: String
        public let author: String
        public let summary: String
        public let url: URL?
        public let genre: String
        public let bookInfo: [BookInfo]
        
        struct BookInfo {
            let value: String
            let title: String
        }
    }

    struct Banner {
        public let id: Int
        public let bookId: Int
        public let url: URL?
    }

    struct Genre {
        let genre: String
        let books: [Book]
    }
}
