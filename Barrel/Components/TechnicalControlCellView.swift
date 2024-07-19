//
//  TechnicalControlCellView.swift
//  Barrel
//
//  Created by KaayZenn on 27/04/2024.
//

import SwiftUI

struct TechnicalControlCellView: View {
    
    // Builder
    @ObservedObject var vehicleSheet: VehicleSheetEntity
    
    // MARK: -
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment :.bottom) {
                Text(vehicleSheet.daysRemainingBeforeTheNextTechnicalControl().formatted())
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                Text("jours restants")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .offset(y: -4)
            }
            if let nextDate = vehicleSheet.dateOfTheNextTechnicalControl() {
                Text("Le prochain contrôle technique sera à faire le **\(nextDate.formatted(date: .complete, time: .omitted))**")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .backgroundComponent()
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    TechnicalControlCellView(vehicleSheet: .preview)
        .preferredColorScheme(.dark)
        .padding()
}
