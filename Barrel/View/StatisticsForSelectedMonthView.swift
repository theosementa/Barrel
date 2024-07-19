//
//  StatisticsForSelectedMonthView.swift
//  Barrel
//
//  Created by KaayZenn on 23/04/2024.
//

import SwiftUI

struct StatisticsForSelectedMonthView: View {
    
    // Builder
    @Bindable var viewModel: StatisticsForSelectedMonthViewModel
    
    // Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: -
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                StatisticCellView(
                    title: "\(HistoryViewModel().monthYearString(from: viewModel.comp)) - TOTAL",
                    subTitle: "Addition de toutes les entrées du mois") {
                        VStack(spacing: 10) {
                            StatisticsCellView(
                                text: "Dépenses",
                                amount: viewModel.amountOfExpensesOfTheMonth().formatWith(num: 2) + " €"
                            )
                            
                            StatisticsCellView(
                                text: "Kilomètres parcourus",
                                amount: viewModel.distanceTravelledOfTheMonth().formatted() + " KM"
                            )
                            
                            StatisticsCellView(
                                text: "Litres consommés",
                                amount: viewModel.litresConsumedOfTheMonth().formatWith(num: 2) + " L"
                            )
                        }
                    }
                
                StatisticCellView(
                    title: "\(HistoryViewModel().monthYearString(from: viewModel.comp)) - MOYENNE",
                    subTitle: "Moyenne de chaque entrées du mois") {
                        VStack(spacing: 10) {
                            StatisticsCellView(
                                text: "Dépenses",
                                amount: viewModel.averageOfExpensesOfTheMonth().formatWith(num: 2) + " €"
                            )
                            
                            StatisticsCellView(
                                text: "Kilomètres parcourus",
                                amount: viewModel.averageOfAutonomyOfTheMonth().formatted() + " KM"
                            )
                            
                            StatisticsCellView(
                                text: "Litres consommés",
                                amount: viewModel.averageOfConsumptionBy100km().formatWith(num: 2) + " L"
                            )
                        }
                    }
            } // End VStack
            .padding()
        } // End ScrollView
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }, label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.label)
                })
            }
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    StatisticsForSelectedMonthView(viewModel: .init(comp: DateComponents()))
}
