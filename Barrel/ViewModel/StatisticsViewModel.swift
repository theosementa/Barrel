//
//  StatisticsViewModel.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import Foundation

@Observable
final class StatisticsViewModel {
    
    var selectedTab: Int = 0
    var selectedViewModel: StatisticsForSelectedMonthViewModel? = nil
    
    var viewModels: [StatisticsForSelectedMonthViewModel] = []
    
    init() {
        if EntryManager.shared.entries.isEmpty {
            EntryManager.shared.fetchEntries()
        }
        self.viewModels = fetchViewModels()
    }
}

extension StatisticsViewModel {
        
    func fetchViewModels() -> [StatisticsForSelectedMonthViewModel] {
        let entries = EntryManager.shared.entries
        guard !entries.isEmpty else { return [] }
        
        var viewModels: [StatisticsForSelectedMonthViewModel] = []
        var uniqueMonthsSet: Set<DateComponents> = Set()
        
        for entry in entries {
            let dateComponents = Calendar.current.dateComponents([.year, .month], from: entry.date)
            uniqueMonthsSet.insert(dateComponents)
        }
        
        let months = Array(uniqueMonthsSet).sorted { (lhs, rhs) -> Bool in
            if lhs.year != rhs.year {
                return lhs.year ?? 0 > rhs.year ?? 0
            } else {
                return lhs.month ?? 0 > rhs.month ?? 0
            }
        }
        
        for month in months {
            viewModels.append(.init(comp: month))
        }
        
        return viewModels
            .sorted { $0.comp.toDate() ?? .now > $1.comp.toDate() ?? .now }
    }
        
}
