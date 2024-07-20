//
//  Date.swift
//  Barrel
//
//  Created by KaayZenn on 28/04/2024.
//

import Foundation
import TheoKit

extension Date {
    
    func toMonthAndYear() -> String {
        return self.month.capitalized + " " + year
    }
    
    func toISO8601String() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: self)
    }
    
}
