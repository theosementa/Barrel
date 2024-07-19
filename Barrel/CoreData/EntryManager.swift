//
//  EntryManager.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import Foundation

@Observable
final class EntryManager {
    static let shared = EntryManager()
    let viewContext = PersistenceController.shared.container.viewContext
    
    var entries: [EntryEntity] = []
}

extension EntryManager {
    
    func fetchEntries() {
        let request = EntryEntity.fetchRequest()
        do {
            let results = try viewContext.fetch(request)
            self.entries = results
                .sorted(by: { $0.date > $1.date })
        } catch {
            print("⚠️ Fail to fetch entries : \(error.localizedDescription)")
        }
    }
    
}

extension EntryManager {
    
    var estimateMileageFortheNextFullTank: Int {
        if entries.count > 1 {
            
            let mileages = entries
                .map { $0.mileage }
                .sorted(by: <)
            
            if mileages.count > 1, let firstEntry = mileages.first, let lastEntry = mileages.last {
                let avgAutonomy = Int(lastEntry - firstEntry) / (mileages.count - 1)
                return Int(lastEntry) + avgAutonomy
            }
        }
        return 0
    }
    
    var estimateDurationOfTankInDays: Int {
        if entries.count > 1,
           let firstEntry = entries.last,
           let lastEntry = entries.first,
           let days = firstEntry.date.daysBetween(to: lastEntry.date) {
            return days / entries.count - 1
        }
        
        return 0
    }
        
    func distanceTravelled() -> Int {
        let mileages = entries
            .map { $0.mileage }
            .sorted(by: <)
        
        if mileages.count > 1 {
            if let firstEntry = mileages.first, let lastEntry = mileages.last {
                return Int(lastEntry - firstEntry)
            }
        }
        return 0
    }
    
    var estimateMileageToTheEndOfYear: Int {
        guard let firstEntry = entries.last else { return 0 }
        guard let daysSinceStart = firstEntry.date.daysBetween(to: Date()) else { return 0 }
        guard let lastDayOfTheYear = Date().lastDayOfYear() else { return 0 }
        guard let daysToEndOfYear = Date().daysBetween(to: lastDayOfTheYear) else { return 0 }
        
        guard daysSinceStart > 0 else { return 0 }
        
        let totalDistanceTravelled = distanceTravelled()
        guard totalDistanceTravelled > 0 else { return 0 }
        
        let avgKmPerDay = totalDistanceTravelled / daysSinceStart
        let nextMileageToTheEnd = avgKmPerDay * daysToEndOfYear
        
        return nextMileageToTheEnd
    }
    
    var estimateMileageAtTheEndOfYear: Int {
        guard let lastEntry = entries.first else { return 0 }
        return lastEntry.mileage.toInt() + estimateMileageToTheEndOfYear
    }
}
