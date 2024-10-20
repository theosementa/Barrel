//
//  CarEntry.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import Foundation

final class CarEntry: Codable, Identifiable, ObservableObject {
    @Published var id: Int?
    @Published var mileage: Int?
    @Published var price: Double?
    @Published var liters: Double?
    @Published var dateString: String?
    
    internal init(id: Int? = nil, mileage: Int? = nil, price: Double? = nil, liters: Double? = nil, date: String? = nil) {
        self.id = id
        self.mileage = mileage
        self.price = price
        self.liters = liters
        self.dateString = date
    }
    
    private enum CodingKeys: CodingKey {
        case id
        case mileage
        case price
        case liters
        case date
    }
    
    required init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<CarEntry.CodingKeys> = try decoder.container(keyedBy: CarEntry.CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: CarEntry.CodingKeys.id)
        self.mileage = try container.decodeIfPresent(Int.self, forKey: CarEntry.CodingKeys.mileage)
        self.price = try container.decodeIfPresent(Double.self, forKey: CarEntry.CodingKeys.price)
        self.liters = try container.decodeIfPresent(Double.self, forKey: CarEntry.CodingKeys.liters)
        self.dateString = try container.decodeIfPresent(String.self, forKey: CarEntry.CodingKeys.date)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CarEntry.CodingKeys.self)
        
        try container.encodeIfPresent(self.id, forKey: CarEntry.CodingKeys.id)
        try container.encodeIfPresent(self.mileage, forKey: CarEntry.CodingKeys.mileage)
        try container.encodeIfPresent(self.price, forKey: CarEntry.CodingKeys.price)
        try container.encodeIfPresent(self.liters, forKey: CarEntry.CodingKeys.liters)
        try container.encodeIfPresent(self.dateString, forKey: CarEntry.CodingKeys.date)
    }
}

extension CarEntry {
    var date: Date {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: self.dateString ?? "") ?? Date()
    }
}


// MARK: - Preview
extension CarEntry {
    static let preview1: CarEntry = .init(
        id: 1,
        mileage: 67600,
        price: 56.45,
        liters: 39.01,
        date: "2024-04-16T09:57:08Z"
    )
    static let preview2: CarEntry = .init(
        id: 2,
        mileage: 68600,
        price: 78.09,
        liters: 59.56,
        date: "2024-10-01T09:57:08Z"
    )
    static let preview3: CarEntry = .init(
        id: 3,
        mileage: 76546,
        price: 36.12,
        liters: 30.23,
        date: "2024-10-18T09:57:08Z"
    )
}
