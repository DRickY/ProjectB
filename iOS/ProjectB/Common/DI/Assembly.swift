//
//  Assembly.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import Foundation
import FirebaseRemoteConfig

enum Assembly {
    static func assemble() {
        Container.default.register(registerFirebase())
        
        Container.default.register(LibraryRepositoryImpl() as LibraryRepository)
    }
    
    static func registerFirebase() -> FirebaseService {
        let config = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 1800
        config.configSettings = settings
        
        return FirebaseServiceImpl(config: config) as FirebaseService
    }
}

