//
//  String.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func toDouble() -> Double {
        let stringFormated = self.replacingOccurrences(of: ",", with: ".")
        return Double(stringFormated) ?? 0
    }
    
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    
    func isoToDate() -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return isoFormatter.date(from: self)
    }
    
    func isoToDateString() -> String? {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoDateFormatter.date(from: self) else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: date)
    }
}
