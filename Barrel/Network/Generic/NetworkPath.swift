//
//  NetworkConstant.swift
//  LifeFlow
//
//  Created by Theo Sementa on 09/03/2024.
//

import Foundation

struct NetworkPath {
    static let baseURL: String = "https://theodev.myftp.org:85"
    
    struct User {
        static let me: String = "/user/me"
        static let register: String = "/user/register"
        static let login: String = "/user/login"
        static func refreshToken(refreshToken: String) -> String {
            return "/user/refresh-token/\(refreshToken)"
        }
    }
    
    struct Car {
        static let get: String = "/car"
        static let create: String = "/car"
        static func delete(_ id: Int) -> String {
            return "/car/\(id)"
        }
    }
    
    struct Entry {
        static let create: String = "/entry"
        static func get(_ id: Int) -> String {
            return "/entry/\(id)"
        }
        static func delete(_ id: Int) -> String {
            return "/entry/\(id)"
        }
        static func edit(_ id: Int) -> String {
            return "/entry/\(id)"
        }
    }
}
