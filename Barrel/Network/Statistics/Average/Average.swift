//
//  Average.swift
//  Barrel
//
//  Created by Theo Sementa on 20/10/2024.
//

import Foundation

final class Average: Identifiable, Codable, ObservableObject {
    @Published var id: Int?
    @Published var mileagePerDay: Double?
    @Published var mileagePerMonth: Double?
    @Published var mileagePerYear: Double?
    
    private enum CodingKeys: CodingKey {
        case id
        case mileagePerDay
        case mileagePerMonth
        case mileagePerYear
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(mileagePerDay, forKey: .mileagePerDay)
        try container.encodeIfPresent(mileagePerMonth, forKey: .mileagePerMonth)
        try container.encodeIfPresent(mileagePerYear, forKey: .mileagePerYear)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        mileagePerDay = try container.decodeIfPresent(Double.self, forKey: .mileagePerDay)
        mileagePerMonth = try container.decodeIfPresent(Double.self, forKey: .mileagePerMonth)
        mileagePerYear = try container.decodeIfPresent(Double.self, forKey: .mileagePerYear)
    }
}
