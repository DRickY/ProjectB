//
//  Transformer.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import Combine
import Foundation

extension Publisher {
    func object<M: Mapper>(to responseMapper: M) -> AnyPublisher<M.To, Error>
    where M.From: Decodable, Output == Data {
        self.apply(transform: ObjectDecoder(responseMapper))
    }
}

struct ObjectDecoder<M: Mapper>: Transformer where M.From: Decodable {
    let mapper: M
    
    init(_ mapper: M) {
        self.mapper = mapper
    }
    
    func transform<E: Error>(from: AnyPublisher<Data, E>) -> AnyPublisher<M.To, Error> {
        from.map(using: JSONMapper<M.From>())
            .map(using: mapper)
            .handleEvents(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    debugPrint("DEBUG: MAPPER \(error)")
                }
            })
            .eraseToAnyPublisher()
    }
}

struct JSONMapper<Model: Decodable>: Mapper {
    private var decoder: JSONDecoder {
        let coder = JSONDecoder()
        coder.keyDecodingStrategy = .convertFromSnakeCase
        
        return coder
    }
    
    func map(from object: Data) throws -> Model {
        do {
            return try decoder.decode(Model.self, from: object)
        } catch {
            throw FirebaseError.mappingError(error)
        }
    }
}

