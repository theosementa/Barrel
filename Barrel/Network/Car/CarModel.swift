//
//  CarModel.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import Foundation

final class CarModel: Codable, Identifiable, ObservableObject {
    @Published var id: Int?
    @Published var name: String?
    @Published var entries: [CarEntry]?
    @Published var statistics: Statistics?
    
    internal init(id: Int? = nil, name: String? = nil, entries: [CarEntry]? = nil, statistics: Statistics? = nil) {
        self.id = id
        self.name = name
        self.entries = entries
        self.statistics = statistics
    }
    
    /// body - used to create a new car
    init(name: String) {
        self.id = nil
        self.name = name
        self.entries = nil
        self.statistics = nil
    }
    
    private enum CodingKeys: CodingKey {
        case id
        case name
        case entries
        case statistics
    }
    
    required init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<CarModel.CodingKeys> = try decoder.container(keyedBy: CarModel.CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: CarModel.CodingKeys.id)
        self.name = try container.decodeIfPresent(String.self, forKey: CarModel.CodingKeys.name)
        self.entries = try container.decodeIfPresent([CarEntry].self, forKey: CarModel.CodingKeys.entries)
        self.statistics = try container.decodeIfPresent(Statistics.self, forKey: CarModel.CodingKeys.statistics)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container: KeyedEncodingContainer<CarModel.CodingKeys> = encoder.container(keyedBy: CarModel.CodingKeys.self)
        
        try container.encodeIfPresent(self.id, forKey: CarModel.CodingKeys.id)
        try container.encodeIfPresent(self.name, forKey: CarModel.CodingKeys.name)
        try container.encodeIfPresent(self.entries, forKey: CarModel.CodingKeys.entries)
        try container.encodeIfPresent(self.statistics, forKey: CarModel.CodingKeys.statistics)
    }
}

// MARK: - Utils Mileage
extension CarModel {
    var mileages: [MileageData] {
        if let entries {
            return entries
                .filter { $0.mileage != 0 }
                .map { MileageData(value: $0.mileage!, date: $0.date) }
                .sorted { $0.value < $1.value }
        } else { return [] }
    }
    
    var firstMileage: MileageData? {
        return mileages.first
    }
    
    var lastMileage: MileageData? {
        return mileages.last
    }
    
    var mileageTraveled: Double {
        guard mileages.count > 1,
              let firstMileage = mileages.first,
              let lastMileage = mileages.last else { return 0 }
        return Double(lastMileage.value - firstMileage.value)
    }
    
    var daysTraveled: Double {
        guard mileages.count > 1,
              let firstMileage = mileages.first,
              let lastMileage = mileages.last else { return 0 }
        return lastMileage.date.daysSince(firstMileage.date)
    }
    
    var averageMileagePerDay: Double {
        return mileageTraveled / daysTraveled
    }
    
    var estimatedMileageAtEndOfCurrentYear: Double {
        guard mileages.count > 1, let lastMileage = mileages.last else { return 0 }
                                
        let daysToEndOfYear = lastMileage.date.daysToEndOfYear
        let estimatedAdditionalMileage = daysToEndOfYear * averageMileagePerDay
        let estimatedTotal = Double(lastMileage.value) + estimatedAdditionalMileage
        
        return estimatedTotal
    }
    
    var estimatedMileageAtEndOfCurrentMonth: Double {
        guard mileages.count > 1, let lastMileage = mileages.last else { return 0 }
                                
        let daysToEndOfMonth = lastMileage.date.daysToEndOfMonth
        let estimatedAdditionalMileage = daysToEndOfMonth * averageMileagePerDay
        let estimatedTotal = Double(lastMileage.value) + estimatedAdditionalMileage
        
        return estimatedTotal
    }
    
    /// Calculate average mileage per month (based on 30.44 days per month)
    var averageMileagePerMonth: Double {
        guard daysTraveled > 0 else { return 0 }
        
        let monthsTraveled = Double(daysTraveled) / 30.44 // Average days in a month
        
        return mileageTraveled / monthsTraveled
    }
    
    /// Calculate average mileage per year (based on 365.25 days per year)
    var averageMileagePerYear: Double {
        guard daysTraveled > 0 else { return 0 }
        
        let yearsTraveled = Double(daysTraveled) / 365.25 // Average days in a year including leap years
        
        return mileageTraveled / yearsTraveled
    }
}

// MARK: - Preview
extension CarModel {
    static let preview: CarModel = .init(
        id: 1,
        name: "Audi A3 Sportback",
        entries: [
            .preview1,
            //            .preview2,
            .preview3
        ]
    )
}
