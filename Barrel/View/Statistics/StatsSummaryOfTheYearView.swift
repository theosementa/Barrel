//
//  StatsSummaryOfTheYearView.swift
//  Barrel
//
//  Created by KaayZenn on 01/05/2024.
//

import SwiftUI

struct StatsSummaryOfTheYearView: View {
    
    // Custom
    @State private var viewModel = StatsSummaryOfTheYearViewModel()
    
    // Date
    let currentDate: Date = Date()
    
    // MARK: -
    var body: some View {
        VStack(spacing: 16) {
            StatsSummaryTotalView(
                title: "TOTAL - \(currentDate.year)",
                subTitle: "Addition de toutes les entrées de \(currentDate.year)",
                amount: viewModel.amountOfAllExpenses(),
                distanceTravelled: viewModel.distanceTravelled(),
                litresConsumed: viewModel.litresConsumed(),
                numberOfEntries: viewModel.entriesOfTheYear.count
            )
            
            StatsSummaryAverageView(
                title: "MOYENNE",
                subTitle: "Moyenne de toutes les entrées de \(currentDate.year)",
                avgOfAmount: viewModel.averageOfAmount(),
                avgOfLitresConsumed: viewModel.averageOfLitreConsumed(),
                avgOfConsumption: viewModel.averageOfConsumptionBy100km(),
                avgAutonomy: viewModel.averageAutonomy()
            )
            
            StatsChartView(
                title: "Moyenne du prix du litre",
                subTitle: "Graphique représentant l’évolution du prix du litre",
                chartType: .priceOfLitre,
                entries: Array(viewModel.entriesOfTheYear.prefix(10)),
                minValue: viewModel.minValueForPriceOfLitre,
                maxValue: viewModel.maxValueForPriceOfLitre
            )
            
            StatsChartView(
                title: "Evolution du kilomètrage",
                subTitle: "Graphique représentant l’évolution du kilomètrage",
                chartType: .mileages,
                entries: Array(viewModel.entriesOfTheYear.prefix(10)),
                minValue: Double(viewModel.minValueForMileage),
                maxValue: Double(viewModel.maxValueForMileage)
            )
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    StatsSummaryOfTheYearView()
}

//VStack(spacing: 32) {
//    ForEach(viewModel.viewModels, id: \.self) { viewModel in
//        let date = Calendar.current.date(from: viewModel.comp)
//        VStack(spacing: 16) {
//            StatsSummaryTotalView(
//                title: "TOTAL - \(date?.month ?? "") \(date?.year ?? "")",
//                subTitle: "Addition de toutes les entrées du mois",
//                amount: viewModel.amountOfExpensesOfTheMonth(),
//                distanceTravelled: viewModel.distanceTravelledOfTheMonth(),
//                litresConsumed: viewModel.litresConsumedOfTheMonth()
//            )
//            StatsSummaryAverageView(
//                title: "MOYENNE - \(date?.month ?? "") \(date?.year ?? "")",
//                subTitle: "Moyenne de toutes les entrées du mois",
//                avgOfAmount: viewModel.averageOfExpensesOfTheMonth(),
//                avgOfLitresConsumed: viewModel.averageOfLitresConsumed(),
//                avgOfConsumption: viewModel.averageOfConsumptionBy100km(),
//                avgAutonomy: viewModel.averageOfAutonomyOfTheMonth()
//            )
//        }
//    }
//}
