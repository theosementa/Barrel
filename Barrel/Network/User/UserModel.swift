//
//  UserModel.swift
//  TCO
//
//  Created by Theo Sementa on 02/10/2024.
//

import Foundation

struct UserModel: Codable, Equatable, Identifiable {
    let id: Int?
    let username: String?
    let password: String?
    let token: String?
    let refreshToken: String?
    
    init(id: Int?, username: String?, password: String?, token: String?, refreshToken: String?) {
        self.id = id
        self.username = username
        self.password = password
        self.token = token
        self.refreshToken = refreshToken
    }
    
    /// body - Used to create a new user
    init(username: String, password: String) {
        self.id = nil
        self.username = username
        self.password = password
        self.token = nil
        self.refreshToken = nil
    }
}

extension UserModel {
    static let preview: UserModel = .init(
        username: "theosementa",
        password: "T33P455W0RD"
    )
}
