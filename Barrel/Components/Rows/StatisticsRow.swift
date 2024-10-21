//
//  StatisticsRow.swift
//  Barrel
//
//  Created by Theo Sementa on 21/10/2024.
//

import SwiftUI

struct StatisticsData: Hashable {
    var text: String
    var value: Double
    var formatter: DoubleFormatter
}

struct StatisticsRow: View {
    
    var title: String
    var statistics: [StatisticsData]
    
    // MARK: -
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 8)
            ForEach(statistics, id: \.self) { stat in
                HStack(spacing: 8) {
                    Text(stat.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(stat.value.format(stat.formatter) + " km")
                        .fontWeight(.bold)
                }
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
    StatisticsRow(title: "Preview", statistics: [
        .init(text: "Hello preview", value: 34.2, formatter: .oneDigit)
    ])
}
