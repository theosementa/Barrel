//
//  CarModel.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import Foundation

struct CarModel: Codable, Identifiable {
    var id: Int?
    var name: String?
    var entries: [CarEntry]?
    
    /// body - used to create a new car
    init(id: Int? = nil, name: String, entries: [CarEntry]? = nil) {
        self.id = id
        self.name = name
        self.entries = entries
    }
    
    var mileages: [Int] {
        if let entries {
            return entries
                .map { $0.mileage ?? 0 }
                .filter { $0 != 0 }
                .sorted(by: <)
        } else { return [] }
    }
}

extension CarModel {
    static let preview: Self = .init(
        id: 1,
        name: "Audi A3 Sportback",
        entries: [
            .preview1,
            .preview2,
            .preview3
        ]
    )
}
