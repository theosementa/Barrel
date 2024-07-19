//
//  Double.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import Foundation

extension Double {
    
    func formatWith(num: Int) -> String {
        return String(format: "%.\(num)f", self)
    }
    
}
