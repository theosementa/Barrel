//
//  StatsOfTheCurrentMonthView.swift
//  Barrel
//
//  Created by KaayZenn on 01/05/2024.
//

import SwiftUI

struct StatsOfTheCurrentMonthView: View {
    
    // Builder
    @Binding var viewModel: StatisticsForSelectedMonthViewModel
        
    // Date
    var currentDate: Date {
        return viewModel.comp.toDate() ?? .now
    }
    
    // MARK: -
    var body: some View {
        VStack(spacing: 16) {
            StatsSummaryTotalView(
                title: "TOTAL - \(currentDate.month) \(currentDate.year)",
                subTitle: "Addition des entrées du mois",
                amount: viewModel.amountOfExpensesOfTheMonth(),
                distanceTravelled: viewModel.distanceTravelledOfTheMonth(),
                litresConsumed: viewModel.litresConsumedOfTheMonth(),
                numberOfEntries: viewModel.entriesOfTheMonth.count
            )
            
            if viewModel.entriesOfTheMonth.count > 1 {
                StatsSummaryAverageView(
                    title: "MOYENNE - \(currentDate.month) \(currentDate.year)",
                    subTitle: "Moyenne des entrées du mois",
                    avgOfAmount: viewModel.averageOfExpensesOfTheMonth(),
                    avgOfLitresConsumed: viewModel.averageOfLitresConsumed(),
                    avgOfConsumption: viewModel.averageOfConsumptionBy100km(),
                    avgAutonomy:viewModel.averageOfAutonomyOfTheMonth()
                )
                
                StatsChartView(
                    title: "Moyenne du prix du litre",
                    subTitle: "Graphique représentant l’évolution du prix du litre",
                    chartType: .priceOfLitre,
                    entries: Array(viewModel.entriesOfTheMonth.prefix(10)),
                    minValue: viewModel.minValueForPriceOfLitre,
                    maxValue: viewModel.maxValueForPriceOfLitre
                )
                
                StatsChartView(
                    title: "Evolution du kilomètrage",
                    subTitle: "Graphique représentant l’évolution du kilomètrage",
                    chartType: .mileages,
                    entries: Array(viewModel.entriesOfTheMonth.prefix(10)),
                    minValue: Double(viewModel.minValueForMileage),
                    maxValue: Double(viewModel.maxValueForMileage)
                )
            }
        }
    } // End body
} // End struct

// MARK: - Preview
//#Preview {
//    StatsOfTheCurrentMonthView()
//}
