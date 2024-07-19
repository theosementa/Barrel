//
//  VehicleSheetCellView.swift
//  Barrel
//
//  Created by KaayZenn on 27/04/2024.
//

import SwiftUI

struct VehicleSheetCellView: View {
    
    // Builder
    var title: String
    var text: String
    var unit: String?
    
    // MARK: -
    var body: some View {
        HStack {
            Text(text + " " + (unit ?? ""))
                .font(.system(size: 18, weight: .medium, design: .rounded))
            Spacer()
        }
        .backgroundComponent()
        .overlay(alignment: .topTrailing) {
            Text(title)
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .padding(4)
                .padding(.horizontal, 4)
                .background {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.Apple.backgroundComponent)
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(lineWidth: 2)
                        .fill(Color.Apple.componentInComponent)
                }
                .padding(8)
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    VehicleSheetCellView(
        title: "Brand",
        text: "Audi"
    )
    .padding()
    .preferredColorScheme(.dark)
}
