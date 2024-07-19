//
//  CustomTextFieldView.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import SwiftUI

struct CustomTextFieldView: View {
    
    // Builder
    @Binding var text: String
    var placeholder: String
    var unit: String?
    var lastMileage: Int?
    
    // MARK: -
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField(placeholder, text: $text)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                if let unit, !unit.isEmpty {
                    Text(unit)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.Apple.backgroundComponentSheet)
            }
            
            if let lastMileage, lastMileage != 0 {
                Text("Dernier kilomètrage entré : \(lastMileage) KM")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .padding(.leading, 8)
            }
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    VStack {
        CustomTextFieldView(
            text: .constant("32.23"),
            placeholder: "HEY",
            unit: "€"
        )
        .padding()
        
        CustomTextFieldView(
            text: .constant("32.23"),
            placeholder: "HEY",
            unit: "€",
            lastMileage: 67_276
        )
        
        .padding()
    }
    .preferredColorScheme(.dark)
}
