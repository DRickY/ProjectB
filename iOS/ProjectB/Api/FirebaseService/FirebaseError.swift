//
//  FirebaseError.swift
//  ProjectB
//
//  Created by Dmytro on 2/29/24.
//

import Foundation

enum FirebaseError: Error {
    case activationFailed
    case fetchingFailed(String?)
    case mappingError(Error)
}
