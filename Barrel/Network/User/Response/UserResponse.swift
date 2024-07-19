//
//  UserResponse.swift
//  Split
//
//  Created by KaayZenn on 28/05/2024.
//

import Foundation

class UserResponse: Codable, Identifiable, Equatable, ObservableObject, Hashable {
    @Published var id: Int?
    @Published var token: String?
    @Published var entries: [EntryResponse]?
    
    init(id: Int? = nil, token: String? = nil, entries: [EntryResponse]? = nil) {
        self.id = id
        self.token = token
        self.entries = entries
    }
    
    static func == (lhs: UserResponse, rhs: UserResponse) -> Bool {
        return lhs.id == rhs.id &&
               lhs.token == rhs.token &&
               lhs.entries == rhs.entries
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(token)
        hasher.combine(entries)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, token, entries
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.token = try container.decodeIfPresent(String.self, forKey: .token)
        self.entries = try container.decodeIfPresent([EntryResponse].self, forKey: .entries)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(token, forKey: .token)
        try container.encodeIfPresent(entries, forKey: .entries)
    }
}
