//
//  StatsSummaryAverageView.swift
//  Barrel
//
//  Created by KaayZenn on 01/05/2024.
//

import SwiftUI

struct StatsSummaryAverageView: View {
    
    // Builder
    var title: String
    var subTitle: String
    
    var avgOfAmount: Double
    var avgOfLitresConsumed: Double
    var avgOfConsumption: Double
    var avgAutonomy: Int
    
    // MARK: -
    var body: some View {
        StatisticCellView(
            title: title,
            subTitle: subTitle) {
                VStack(spacing: 10) {
                    StatisticsCellView(
                        text: "Dépenses moyenne",
                        amount: avgOfAmount.formatWith(num: 2) + " €"
                    )
                    
                    StatisticsCellView(
                        text: "Litres consommés en moyenne",
                        amount: avgOfLitresConsumed.formatWith(num: 2) + " L"
                    )
                    
                    StatisticsCellView(
                        text: "Consommation moyenne",
                        amount: avgOfConsumption.formatWith(num: 2) + " L/100km"
                    )
                    
                    StatisticsCellView(
                        text: "Autonomie moyenne",
                        amount: avgAutonomy.formatted() + " KM"
                    )
                }
            }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    StatsSummaryAverageView(
        title: "Preview",
        subTitle: "Preview subTitle",
        avgOfAmount: 66.2,
        avgOfLitresConsumed: 35,
        avgOfConsumption: 23,
        avgAutonomy: 10
    )
}
