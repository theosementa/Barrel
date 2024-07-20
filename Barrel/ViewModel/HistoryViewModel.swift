//
//  HistoryViewModel.swift
//  Barrel
//
//  Created by KaayZenn on 23/04/2024.
//

import Foundation

@Observable
final class HistoryViewModel {
    let entryRepo: EntryRepository = .shared
    
    var entriesByMonth: [DateComponents : [EntryResponse]] = [:]
    
}

extension HistoryViewModel {
    
    func sortEntriesByMonth() async {
        await entryRepo.fetchEntries()
        
        entriesByMonth = [:]
        
        for entry in entryRepo.entries {
            if let date = entry.date {
                let month = Calendar.current.dateComponents([.year, .month], from: date)
                
                if var entriesForMonth = entriesByMonth[month] {
                    entriesForMonth.append(entry)
                    entriesByMonth[month] = entriesForMonth
                } else {
                    entriesByMonth[month] = [entry]
                }
            }
        }
    }
    
    func monthYearString(from comp: DateComponents) -> String {
        if let month = comp.month, let year = comp.year {
            let finalMonth = Calendar.current.monthSymbols[month - 1]
            return "\(finalMonth.capitalized) \(year)"
        } else { return "" }
    }
    
}
