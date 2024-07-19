//
//  HistoryViewModel.swift
//  Barrel
//
//  Created by KaayZenn on 23/04/2024.
//

import Foundation

@Observable
final class HistoryViewModel {
    
    var entriesByMonth: [DateComponents : [EntryEntity]] = [:]
    
}

extension HistoryViewModel {
    
    func sortEntriesByMonth() {
        EntryManager.shared.fetchEntries()
        let entries = EntryManager.shared.entries
        
        entriesByMonth = [:]
        
        for entry in entries {
            let month = Calendar.current.dateComponents([.year, .month], from: entry.date)
                        
            if var entriesForMonth = entriesByMonth[month] {
                entriesForMonth.append(entry)
                entriesByMonth[month] = entriesForMonth
            } else {
                entriesByMonth[month] = [entry]
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
