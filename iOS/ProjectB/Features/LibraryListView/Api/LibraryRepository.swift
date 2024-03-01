//
//  LibraryRepository.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import Foundation
import Combine

protocol LibraryRepository {
    func books() -> AnyPublisher<LibraryModel, Error>
}

public final class LibraryRepositoryImpl: LibraryRepository {
    @Inject
    var service: FirebaseService
        
    func books() -> AnyPublisher<LibraryModel, Error> {
        service.fetch("json_data")
            .compactMap { $0 }
            .object(to: BookMapper())
    }
}
