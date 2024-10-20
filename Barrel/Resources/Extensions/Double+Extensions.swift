//
//  Double+Extensions.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import Foundation

enum DoubleFormatter {
    case zeroDigit, oneDigit, twoDigits
    
    var format: String {
        switch self {
        case .zeroDigit: return "%.0f"
        case .oneDigit: return "%.1f"
        case .twoDigits: return "%.2f"
        }
    }
}

extension Double {
    func format(_ formatter: DoubleFormatter) -> String {
        return String(format: formatter.format, self)
    }
}
