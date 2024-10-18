//
//  CarRow.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import SwiftUI

struct CarRow: View {
    
    // Builder
    var car: CarModel
    
    // MARK: -
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(car.name ?? "")
                .font(.system(size: 24, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let lastMileage = car.mileages.last {
                Text("\(lastMileage) km")
                    .font(.system(size: 20, weight: .medium))
            } else {
                Text("Aucun kilométrage n'est renseigné.")
                    .font(.system(size: 16, weight: .medium))
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.Apple.backgroundComponent)
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    CarRow(car: .preview)
        .padding()
        .background(Color.Apple.background)
}
