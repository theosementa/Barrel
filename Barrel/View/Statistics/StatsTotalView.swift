//
//  StatsTotalView.swift
//  Barrel
//
//  Created by KaayZenn on 01/05/2024.
//

import SwiftUI

struct StatsTotalView: View {
    
    // Custom
    @State private var viewModel = StatsTotalViewModel()
    
    // MARK: -
    var body: some View {
        VStack(spacing: 16) {
            StatsSummaryTotalView(
                title: "TOTAL",
                subTitle: "Addition de toutes les entrées depuis le début",
                amount: viewModel.amountOfAllExpenses(),
                distanceTravelled: viewModel.distanceTravelled(),
                litresConsumed: viewModel.litresConsumed(),
                numberOfEntries: viewModel.entries.count
            )
            
            StatsSummaryAverageView(
                title: "MOYENNE",
                subTitle: "Moyenne de toutes les entrées depuis le début",
                avgOfAmount: viewModel.averageOfAmount(),
                avgOfLitresConsumed: viewModel.averageOfLitreConsumed(),
                avgOfConsumption: viewModel.averageOfConsumptionBy100km(),
                avgAutonomy: viewModel.averageAutonomy()
            )
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    StatsTotalView()
}
