//
//  NetworkConstant.swift
//  Essential
//
//  Created by KaayZenn on 09/03/2024.
//

import Foundation

struct NetworkConstant {
    static let baseURL: String = "https://theodev.myftp.org:81"
    
    struct Path {
        
        struct User {
            static let register: String = "/user/register"
            static let login: String = "/user/login"
        }
        
        struct Entry {
            static let entry: String = "/entry"
            static func manageEntry(entryID: Int) -> String {
                return "/entry/\(entryID)"
            }
        }
    }
}
