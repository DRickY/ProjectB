//
//  BookModelDTO.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import Foundation

public struct BookModelDTO: Decodable {
    public let books: [Book]
    public let topBannerSlides: [TopBanner]
    public let youWillLikeSection: [Int]

    public struct Book: Decodable {
        public let id: Int
        public let name: String
        public let author: String
        public let summary: String
        public let genre: String
        public let coverUrl: String
        public let views: String
        public let likes: String
        public let quotes: String
    }

    public struct TopBanner: Decodable {
        public let id: Int
        public let bookId: Int
        public let cover: String
    }
}
