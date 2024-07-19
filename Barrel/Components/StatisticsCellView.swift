//
//  StatisticsCellView.swift
//  Barrel
//
//  Created by KaayZenn on 23/04/2024.
//

import SwiftUI

struct StatisticsCellView: View {
    
    // Builder
    var text: String
    var amount: String
    
    // MARK: -
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 16, weight: .medium, design: .rounded))
            Spacer()
            Text(amount)
                .font(.system(size: 16, weight: .bold, design: .rounded))
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    StatisticsCellView(text: "Test", amount: "23.45€")
}
