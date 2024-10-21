//
//  CarDetailView.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import SwiftUI

struct CarDetailView: View {
    
    // builder
    @ObservedObject var car: CarModel
    
    @EnvironmentObject private var router: NavigationManager
    
    // MARK: -
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let statistics = car.statistics {
                    if let estimation = statistics.estimation {
                        StatisticsRow(
                            title: "Estimation",
                            statistics: [
                                .init(
                                    text: "KM à la fin de l'année",
                                    value: estimation.mileageAtEndOfCurrentYear ?? 0,
                                    formatter: .zeroDigit
                                ),
                                .init(
                                    text: "KM à la fin du mois",
                                    value: estimation.mileageAtEndOfTheCurrentMonth ?? 0,
                                    formatter: .zeroDigit
                                )
                            ]
                        )
                    }
                    
                    if let averages = statistics.average {
                        StatisticsRow(
                            title: "Moyennes",
                            statistics: [
                                .init(
                                    text: "Par jour",
                                    value: averages.mileagePerDay ?? 0,
                                    formatter: .twoDigits
                                ),
                                .init(
                                    text: "Par mois",
                                    value: averages.mileagePerMonth ?? 0,
                                    formatter: .zeroDigit
                                ),
                                .init(
                                    text: "Par an",
                                    value: averages.mileagePerYear ?? 0,
                                    formatter: .zeroDigit
                                )
                            ]
                        )
                    }
                    
                    StatisticsRow(
                        title: "Données passées",
                        statistics: [
                            .init(
                                text: "KM Parcouru",
                                value: car.mileageTraveled,
                                formatter: .zeroDigit
                            )
                        ]
                    )
                }
                VStack(spacing: 8) {
                    Text("Données")
                    if let entries = car.entries {
                        ForEach(entries) { entry in
                            Text("\(entry.id ?? 0): \(entry.mileage ?? 0)km - \(entry.date.formatted(date: .numeric, time: .omitted))")
                        }
                    }
                }
                .padding()
            }
            .padding()
        } // ScrollView
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Apple.background)
        .overlay(alignment: .bottomTrailing) {
            AddButton { router.presentCreateEntry(car: car) }
                .padding()
        }
        .scrollIndicators(.hidden)
        .navigationTitle(car.name ?? "")
    } // body
} // struct

// MARK: - Preview
#Preview {
    CarDetailView(car: .preview)
}
