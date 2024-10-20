//
//  Statistics.swift
//  Barrel
//
//  Created by Theo Sementa on 20/10/2024.
//

import Foundation

final class Statistics: Identifiable, Codable, ObservableObject {
    @Published var id: Int?
    @Published var estimation: Estimation?
    @Published var average: Average?
    
    private enum CodingKeys: CodingKey {
        case id
        case estimation
        case average
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(estimation, forKey: .estimation)
        try container.encodeIfPresent(average, forKey: .average)
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        estimation = try container.decodeIfPresent(Estimation.self, forKey: .estimation)
        average = try container.decodeIfPresent(Average.self, forKey: .average)
    }
}
