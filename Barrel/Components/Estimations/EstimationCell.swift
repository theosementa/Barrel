//
//  EstimationCell.swift
//  Barrel
//
//  Created by KaayZenn on 26/05/2024.
//

import SwiftUI

struct EstimationCell: View {
    
    // Builder
    var value: Int
    var unit: String
    var desc: String
    
    // MARK: -
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment :.bottom) {
                Text(value.formatted())
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                Text(unit)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .offset(y: -4)
            }
            
            Text(desc)
                .font(.system(size: 16, weight: .regular, design: .rounded))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .backgroundComponent()
    } // End body
} // End struct

// MARK: -
#Preview {
    EstimationCell(value: 45000, unit: "km", desc: "Estimation du kilomètrage au prochain plein")
}
