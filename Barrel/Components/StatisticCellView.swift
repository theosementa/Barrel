//
//  StatisticCellView.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import SwiftUI

struct StatisticCellView<Content: View>: View {
    
    // Builder
    var title: String
    var subTitle: String
    var content: () -> Content
    
    // MARK: -
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                Text(subTitle)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(uiColor: .lightGray))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            content()
        }
        .backgroundComponent()
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    StatisticCellView(
        title: "Total",
        subTitle: "Sub title de total",
        content: { EmptyView() }
    )
    .preferredColorScheme(.dark)
    .padding()
}
