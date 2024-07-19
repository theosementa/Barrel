//
//  EntryResponse.swift
//  Barrel
//
//  Created by KaayZenn on 19/07/2024.
//

import Foundation

class EntryResponse: Codable, Identifiable, ObservableObject, Equatable, Hashable {
    @Published var id: Int?
    @Published var price: Double
    @Published var mileage: Int
    @Published var liters: Double?
    @Published var dateIso: String
    
    init(id: Int? = nil, price: Double, mileage: Int, liters: Double? = nil, dateIso: String) {
        self.id = id
        self.price = price
        self.mileage = mileage
        self.liters = liters
        self.dateIso = dateIso
    }
    
    static func == (lhs: EntryResponse, rhs: EntryResponse) -> Bool {
        return lhs.id == rhs.id &&
        lhs.price == rhs.price &&
        lhs.mileage == rhs.mileage &&
        lhs.liters == rhs.liters &&
        lhs.dateIso == rhs.dateIso
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(price)
        hasher.combine(mileage)
        hasher.combine(liters)
        hasher.combine(dateIso)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, price, mileage, liters, dateIso
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.price = try container.decode(Double.self, forKey: .price)
        self.mileage = try container.decode(Int.self, forKey: .mileage)
        self.liters = try container.decodeIfPresent(Double.self, forKey: .liters)
        self.dateIso = try container.decode(String.self, forKey: .dateIso)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(price, forKey: .price)
        try container.encode(mileage, forKey: .mileage)
        try container.encodeIfPresent(liters, forKey: .liters)
        try container.encode(dateIso, forKey: .dateIso)
    }
}
