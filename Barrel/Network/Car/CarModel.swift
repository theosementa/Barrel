//
//  CarModel.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import Foundation

struct CarModel: Codable {
    var id: Int?
    var name: String?
    var entries: [CarEntry]?
    
    /// body - used to create a new car
    init(id: Int? = nil, name: String, entries: [CarEntry]? = nil) {
        self.id = id
        self.name = name
        self.entries = entries
    }
}
