//
//  StatsSummaryTotalView.swift
//  Barrel
//
//  Created by KaayZenn on 01/05/2024.
//

import SwiftUI

struct StatsSummaryTotalView: View {
    
    // Builder
    var title: String
    var subTitle: String
    
    var amount: Double
    var distanceTravelled: Int
    var litresConsumed: Double
    var numberOfEntries: Int
    
    // MARK: -
    var body: some View {
        StatisticCellView(
            title: title,
            subTitle: subTitle) {
                VStack(spacing: 10) {
                    StatisticsCellView(
                        text: "Dépenses",
                        amount: amount.formatWith(num: 2) + " €"
                    )
                    
                    StatisticsCellView(
                        text: "Kilomètres parcourus",
                        amount: distanceTravelled.formatted() + " KM"
                    )
                    
                    StatisticsCellView(
                        text: "Litres consommés",
                        amount: litresConsumed.formatWith(num: 2) + " L"
                    )
                    
                    if numberOfEntries != 0 {
                        StatisticsCellView(
                            text: "Nombres de plein",
                            amount: numberOfEntries.formatted()
                        )
                    }
                }
            }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    StatsSummaryTotalView(
        title: "Preview",
        subTitle: "Preview SubTitle",
        amount: 12.3,
        distanceTravelled: 240,
        litresConsumed: 12,
        numberOfEntries: 2
    )
}
