//
//  Publisher+Transform.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import Combine

public protocol Transformer {
    associatedtype From
    associatedtype To
    
    func transform<E: Error>(from: AnyPublisher<From, E>) -> AnyPublisher<To, Error>
}

extension Publisher {
    public func apply<T: Transformer>(transform: T) -> AnyPublisher<T.To, Error>
    where T.From == Output {
        transform.transform(from: self.eraseToAnyPublisher())
    }
}
