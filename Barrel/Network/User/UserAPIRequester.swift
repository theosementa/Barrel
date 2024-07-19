//
//  UserAPIRequester.swift
//  HappyEat_iOS
//
//  Created by KaayZenn on 09/03/2024.
//

import Foundation

enum UserAPIRequester: APIRequestBuilder {
    case register
    case login
}

extension UserAPIRequester {
    var path: String {
        switch self {
        case .register:
            return NetworkConstant.Path.User.register
        case .login:
            return NetworkConstant.Path.User.login
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .register:
            return .GET
        case .login:
            return .GET
        }
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
    
    var isTokenNeeded: Bool {
        switch self {
        case .register:
            return false
        case .login:
            return true
        }
    }
    
    var body: Data? {
        return nil
    }
    
}
