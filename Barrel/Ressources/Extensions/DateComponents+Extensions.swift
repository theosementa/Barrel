//
//  DateComponents+Extensions.swift
//  Barrel
//
//  Created by KaayZenn on 26/05/2024.
//

import Foundation

extension DateComponents {
    
    public func toDate() -> Date? {
        return Calendar.current.date(from: self)
    }
    
    func toMonth() -> String {
        if let month {
            let monthString = Calendar.current.monthSymbols[month - 1]
            return monthString.capitalized
        }
            
        return ""
    }
    
    func toMonthAndYear() -> String {
        if let month, let year {
            let monthString = Calendar.current.monthSymbols[month - 1]
            return monthString.capitalized + " " + "\(year)"
        }
            
        return ""
    }
    
}
