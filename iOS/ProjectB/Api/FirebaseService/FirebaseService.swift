//
//  FirebaseService.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import FirebaseRemoteConfig
import Combine

protocol FirebaseService {
    func fetch(_ keyPath: String) -> AnyPublisher<Data?, FirebaseError>
}

public final class FirebaseServiceImpl: FirebaseService {

    private let config: RemoteConfig

    public init(config: RemoteConfig) {
        self.config = config
    }
    
    func fetch(_ keyPath: String) -> AnyPublisher<Data?, FirebaseError> {
        Future<Data?, FirebaseError> { [weak self] promise in
            self?.config.fetch { status, e in
                guard status == .success, e == nil else {
                    promise(.failure(.fetchingFailed(e?.localizedDescription)))
                    return
                }
                
                self?.config.activate { changed, error in
                    guard error == nil else {
                        promise(.failure(.activationFailed))
                        return
                    }
                    
                    promise(.success(self?.config[keyPath].dataValue))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
