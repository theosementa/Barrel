//
//  Date+Extensions.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import Foundation

// MARK: - Utils
extension Date {
    
    /// Returns the number of days between this date and another date
    func daysSince(_ date: Date) -> Double {
        let timeInterval = self.timeIntervalSince(date)
        return timeInterval / 86400.0
    }
    
}

// MARK: - Year
extension Date {
    
    /// Returns the date corresponding to the end of the current year
    var endOfYear: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        guard let startOfNextYear = calendar.date(from: DateComponents(year: components.year! + 1)) else {
            return self
        }
        return calendar.date(byAdding: .second, value: -1, to: startOfNextYear) ?? self
    }
    
    /// Returns the number of days remaining until the end of the year
    var daysToEndOfYear: Double {
        return endOfYear.daysSince(self)
    }
    
}

// MARK: - Month
extension Date {
    
    /// Returns the date corresponding to the end of the current month
    var endOfMonth: Date {
        let calendar = Calendar.current
        guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: self) else {
            return self
        }
        let components = calendar.dateComponents([.year, .month], from: nextMonth)
        guard let startOfNextMonth = calendar.date(from: components) else {
            return self
        }
        return calendar.date(byAdding: .second, value: -1, to: startOfNextMonth) ?? self
    }
    
    /// Returns the number of days remaining until the end of the month
    var daysToEndOfMonth: Double {
        return endOfMonth.daysSince(self)
    }
    
}
