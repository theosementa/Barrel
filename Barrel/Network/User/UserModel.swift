//
//  UserModel.swift
//  TCO
//
//  Created by Theo Sementa on 02/10/2024.
//

import Foundation

struct UserModel: Codable, Equatable, Identifiable {
    let id: Int?
    let firstName: String?
    let username: String?
    let token: String?
    let refreshToken: String?
    
    init(id: Int?, firstName: String?, username: String?, token: String?, refreshToken: String?) {
        self.id = id
        self.firstName = firstName
        self.username = username
        self.token = token
        self.refreshToken = refreshToken
    }
    
    /// body - Used to create a new user
    init(firstName: String, username: String) {
        self.id = nil
        self.firstName = firstName
        self.username = username
        self.token = nil
        self.refreshToken = nil
    }
}

extension UserModel {
    static let preview: UserModel = .init(
        firstName: "Theo",
        username: "theosementa"
    )
}
