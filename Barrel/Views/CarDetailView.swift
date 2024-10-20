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
    
    // MARK: -
    var body: some View {
        ScrollView {
            if let statistics = car.statistics {
                if let estimation = statistics.estimation {
                    VStack(spacing: 8) {
                        Text("Estimation")
                        Text("KM à la fin de l'année : \(estimation.mileageAtEndOfCurrentYear?.format(.zeroDigit) ?? "")")
                        Text("KM à la fin du mois : \(estimation.mileageAtEndOfTheCurrentMonth?.format(.zeroDigit) ?? "")")
                    }
                    .padding()
                }
                if let averages = statistics.average {
                    VStack(spacing: 8) {
                        Text("Moyennes")
                        Text("Moyenne par jour : \(averages.mileagePerDay?.format(.twoDigits) ?? "")km")
                        Text("Moyenne par mois : \(averages.mileagePerMonth?.format(.zeroDigit) ?? "")km")
                        Text("Moyenne par an : \(averages.mileagePerYear?.format(.zeroDigit) ?? "")km")
                    }
                    .padding()
                }
                VStack(spacing: 8) {
                    Text("Données passées")
                    Text("KM Parcouru : \(car.mileageTraveled.format(.zeroDigit))km")
                }
                .padding()
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
        .scrollIndicators(.hidden)
        .navigationTitle(car.name ?? "")
    } // body
} // struct

// MARK: - Preview
#Preview {
    CarDetailView(car: .preview)
}
