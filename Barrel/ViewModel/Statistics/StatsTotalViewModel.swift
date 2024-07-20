//
//  StatsTotalViewModel.swift
//  Barrel
//
//  Created by KaayZenn on 01/05/2024.
//

import Foundation

@Observable
final class StatsTotalViewModel {
    
    let entries = EntryRepository.shared.entries
    
    var prices: [Double] {
        return entries
            .map { $0.price }
            .sorted(by: <)
    }
    
    var litres: [Double] {
        return entries
            .map { $0.liters ?? 0 }
    }
    
    var mileages: [Int] {
        return entries
            .map { Int($0.mileage) }
            .sorted(by: <)
    }
    
    var pricesOfLitre: [Double] {
        return entries
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

extension StatsTotalViewModel {
    
    func amountOfAllExpenses() -> Double {
        return prices.reduce(0, +)
    }
    
    func litresConsumed() -> Double {
        if let lastEntry = litres.first, litres.count > 1 {
            return litres.reduce(0, +) - lastEntry
        } else {
            return 0
        }
    }
    
    func distanceTravelled() -> Int {
        if mileages.count > 1 {
            if let firstEntry = mileages.first, let lastEntry = mileages.last {
                return Int(lastEntry - firstEntry)
            }
        }
        return 0
    }
    
}

extension StatsTotalViewModel {
    
    func averageOfAmount() -> Double {
        let pricesAdditioned = prices.reduce(0, +)
        if entries.count > 1 {
            return pricesAdditioned / Double(entries.count)
        } else {
            return 0
        }
    }
    
    func averageOfLitreConsumed() -> Double {
        let litresAdditioned = litres.reduce(0, +) - (litres.first ?? 0.0)
        if entries.count > 1 && litresAdditioned > 0{
            return litresAdditioned / Double(entries.count - 1)
        } else { return 0 }
    }
    
    func averageOfConsumptionBy100km() -> Double {
        if distanceTravelled() != 0 && litresConsumed() != 0 {
            return (litresConsumed() / Double(distanceTravelled())) * 100
        } else { return 0 }
    }
    
    func averageAutonomy() -> Int {
        if distanceTravelled() != 0 && mileages.count > 1 {
            return distanceTravelled() / (mileages.count - 1)
        } else { return 0 }
    }
    
}
