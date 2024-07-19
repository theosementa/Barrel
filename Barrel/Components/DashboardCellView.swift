//
//  DashboardCellView.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import SwiftUI

struct DashboardCellView: View {
    
    // Builder
    var icon: String
    var text: String
    var action: () -> Void
    
    // MARK: -
    var body: some View {
        Button(action: action, label: {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .frame(width: 35, height: 35)
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color.Apple.componentInComponent)
                        )
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                }
                
                Text(text)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .padding(.top)
            }
            .backgroundComponent()
        })
        .buttonStyle(PlainButtonStyle())
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    HStack(spacing: 16) {
        DashboardCellView(
            icon: "car.fill",
            text: "My vehicle",
            action: {}
        )
        
        DashboardCellView(
            icon: "car.fill",
            text: "My vehicle",
            action: {}
        )
    }
    .preferredColorScheme(.dark)
    .padding()
}
