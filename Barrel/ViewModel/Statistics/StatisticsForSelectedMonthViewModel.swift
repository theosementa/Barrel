//
//  StatisticsForSelectedMonthViewModel.swift
//  Barrel
//
//  Created by KaayZenn on 23/04/2024.
//

import Foundation

@Observable
final class StatisticsForSelectedMonthViewModel: Hashable {
    
    // Builder
    var comp: DateComponents
    
    // Hashable
    static func == (lhs: StatisticsForSelectedMonthViewModel, rhs: StatisticsForSelectedMonthViewModel) -> Bool {
        return lhs.comp == rhs.comp
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(comp)
    }
    
    // init
    init(comp: DateComponents) {
        self.comp = comp
        if EntryManager.shared.entries.count == 0 {
            EntryManager.shared.fetchEntries()
        }
    }
    
    var entriesOfTheMonth: [EntryEntity] {
        guard let date = Calendar.current.date(from: comp) else {
            return []
        }
        
        let entries = EntryManager.shared.entries
        
        return entries
            .filter { Calendar.current.isDate($0.date, equalTo: date, toGranularity: .month) }
            .sorted(by: { $0.date > $1.date })
    }
    
    var prices: [Double] {
        return entriesOfTheMonth
            .map { $0.price }
            .sorted(by: <)
    }
    
    var litres: [Double] {
        return entriesOfTheMonth
            .map { $0.litres }
    }
    
    var mileages: [Int] {
        return entriesOfTheMonth
            .map { Int($0.mileage) }
            .sorted(by: <)
    }
    
    var pricesOfLitre: [Double] {
        return entriesOfTheMonth
            .map { $0.priceOfLitre }
            .sorted(by: <)
    }
    
    // Prices
    var minValueForPrice: Double {
        if let first = prices.first {
            if (first - 10) < 0 {
                return 0
            } else {
                return first - 10
            }
        } else { return 0 }
    }
    
    var maxValueForPrice: Double {
        if let last = prices.last {
            return last + 10
        } else { return 0 }
    }
    
    // Mileage
    var minValueForMileage: Int {
        if let first = mileages.first {
            return first
        } else { return 0 }
    }
    
    var maxValueForMileage: Int {
        if let last = mileages.last {
            return last
        } else { return 0 }
    }
    
    // Expense by litre
    var minValueForPriceOfLitre: Double {
        if let first = pricesOfLitre.first {
            return first
        } else { return 0 }
    }
    
    var maxValueForPriceOfLitre: Double {
        if let last = pricesOfLitre.last {
            return last
        } else { return 0 }
    }
}

// MARK: - Total of the month
extension StatisticsForSelectedMonthViewModel {
    
    func amountOfExpensesOfTheMonth() -> Double {
        return prices.reduce(0, +)
    }
    
    func litresConsumedOfTheMonth() -> Double {
        if litres.count > 1 {
            return litres.reduce(0, +) - (litres.first ?? 0.0)
        } else {
            return 0
        }
    }
    
    func distanceTravelledOfTheMonth() -> Int {
        if mileages.count > 1 {
            if let lastEntry = mileages.last, let firstEntry = mileages.first {
                return Int(lastEntry - firstEntry)
            }
        }
        return 0
    }
    
}

// MARK: - Average of the month
extension StatisticsForSelectedMonthViewModel {
    
    func averageOfExpensesOfTheMonth() -> Double {
        let amount = prices.reduce(0, +)
        if !entriesOfTheMonth.isEmpty {
            return amount / Double(entriesOfTheMonth.count)
        } else { return 0 }
    }
    
    func averageOfLitresConsumed() -> Double {
        let litresAdditioned = litres.reduce(0, +) - (litres.first ?? 0.0)
        if entriesOfTheMonth.count > 1 && litres.count > 1 && litresAdditioned > 0 {
            return litresAdditioned / Double(entriesOfTheMonth.count - 1)
        } else { return 0 }
    }
    
    func averageOfConsumptionBy100km() -> Double {
        if distanceTravelledOfTheMonth() != 0 && litresConsumedOfTheMonth() != 0 {
            return (litresConsumedOfTheMonth() / Double(distanceTravelledOfTheMonth())) * 100
        } else { return 0 }
    }
    
    func averageOfAutonomyOfTheMonth() -> Int {
        if mileages.count > 1 {
            if let lastEntry = mileages.last, let firstEntry = mileages.first, entriesOfTheMonth.count > 1 {
                return Int(lastEntry - firstEntry) / (entriesOfTheMonth.count - 1)
            }
        }
        return 0
    }
    
}
