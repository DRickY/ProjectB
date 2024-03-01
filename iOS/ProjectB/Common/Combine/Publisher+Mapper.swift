//
//  Publisher+Mapper.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import Combine

public protocol Mapper {
    associatedtype From
    associatedtype To
    
    func map(from object: From) throws -> To
}

extension Publisher {
    public func map<M: Mapper>(using mapper: M) -> AnyPublisher<M.To, Error> where M.From == Output  {
        return tryMap(mapper.map).eraseToAnyPublisher()
    }
}
