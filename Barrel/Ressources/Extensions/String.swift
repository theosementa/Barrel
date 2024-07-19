//
//  String.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import Foundation

extension String {
    
    func convertToDouble() -> Double {
        let stringFormated = self.replacingOccurrences(of: ",", with: ".")
        return Double(stringFormated) ?? 0
    }
    
    func convertToInt() -> Int {
        return Int(self) ?? 0
    }
}
