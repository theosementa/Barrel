//
//  EntryRepository.swift
//  Barrel
//
//  Created by KaayZenn on 19/07/2024.
//

import Foundation

final class EntryRepository: ObservableObject {
    static let shared = EntryRepository()
    
    @Published var entries: [EntryResponse] = []
}

extension EntryRepository {
    
    @MainActor
    func fetchEntries() async {
        do {
            let entries = try await NetworkService.shared.sendRequest(
                apiBuilder: EntryAPIRequester.getEntries,
                responseModel: [EntryResponse].self
            )
            
            self.entries = entries
                .sorted(by: { $0.date ?? .now > $1.date ?? .now })
            
            AppManager.shared.state = .success
        } catch let error {
            if let networkError = error as? NetworkError {
                BannerManager.shared.banner = networkError.banner
            }
        }
    }
    
    @MainActor
    func createEntry(body: EntryBody) async {
        do {
            let entry = try await NetworkService.shared.sendRequest(
                apiBuilder: EntryAPIRequester.createEntry(body: body),
                responseModel: EntryResponse.self
            )
            
            self.entries.append(entry)
            
            self.entries = entries
                .sorted(by: { $0.date ?? .now > $1.date ?? .now })
        } catch let error {
            if let networkError = error as? NetworkError {
                BannerManager.shared.banner = networkError.banner
            }
        }
    }
    
    @MainActor
    func deleteEntry(entryID: Int) async {
        do {
            let entry = try await NetworkService.shared.sendRequest(
                apiBuilder: EntryAPIRequester.deleteEntry(entryID: entryID),
                responseModel: EntryResponse.self
            )
            
            self.entries.removeAll(where: { $0.id == entry.id })
            
            self.entries = entries
                .sorted(by: { $0.date ?? .now > $1.date ?? .now })
        } catch let error {
            if let networkError = error as? NetworkError {
                BannerManager.shared.banner = networkError.banner
            }
        }
    }
    
}

extension EntryRepository {
    
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
           let firstEntryDate = firstEntry.date,
           let lastEntryDate = lastEntry.date,
           let days = firstEntryDate.daysBetween(to: lastEntryDate) {
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
        guard let firstEntryDate = firstEntry.date else { return 0 }
        guard let daysSinceStart = firstEntryDate.daysBetween(to: Date()) else { return 0 }
        guard let lastDayOfTheYear = Date().endOfYear else { return 0 }
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
        return lastEntry.mileage + estimateMileageToTheEndOfYear
    }
}
