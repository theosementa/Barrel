//
//  Estimation.swift
//  Barrel
//
//  Created by Theo Sementa on 20/10/2024.
//

import Foundation

final class Estimation: Identifiable, Codable, ObservableObject {
    @Published var id: Int?
    @Published var mileageAtEndOfCurrentYear: Double?
    @Published var mileageAtEndOfTheCurrentMonth: Double?
    
    private enum CodingKeys: CodingKey {
        case id
        case mileageAtEndOfCurrentYear
        case mileageAtEndOfTheCurrentMonth
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(mileageAtEndOfCurrentYear, forKey: .mileageAtEndOfCurrentYear)
        try container.encodeIfPresent(mileageAtEndOfTheCurrentMonth, forKey: .mileageAtEndOfTheCurrentMonth)
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        mileageAtEndOfCurrentYear = try container.decodeIfPresent(Double.self, forKey: .mileageAtEndOfCurrentYear)
        mileageAtEndOfTheCurrentMonth = try container.decodeIfPresent(Double.self, forKey: .mileageAtEndOfTheCurrentMonth)
    }
}
