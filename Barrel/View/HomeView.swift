//
//  HomeView.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import SwiftUI

struct HomeView: View {
    
    // Builder
    var router: NavigationManager
    
    // EnvironmentObject
    @EnvironmentObject private var entryRepo: EntryRepository
    
    // Custom
    @Bindable var vehicleSheetManager = VehicleSheetManager.shared
    
    // MARK: -
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    DashboardCellView(
                        icon: "car.fill",
                        text: "Mon véhicule",
                        action: { router.pushMyVehicle() }
                    )
                    
                    DashboardCellView(
                        icon: "chart.bar.fill",
                        text: "Mes statistiques",
                        action: { router.pushStatistics() }
                    )
                }
                
                if let vehicleSheet = vehicleSheetManager.vehicleSheet, vehicleSheet.dateTechnicalControl != nil {
                    TechnicalControlCellView(vehicleSheet: vehicleSheet)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            if entryRepo.entries.count > 1 {
                VStack {
                    HStack {
                        Text("Estimations")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.label)
                        Spacer()
                    }
                    
                    if entryRepo.estimateMileageFortheNextFullTank != 0 {
                        EstimationCell(
                            value: entryRepo.estimateMileageFortheNextFullTank,
                            unit: "km",
                            desc: "Estimation du kilomètrage au prochain plein"
                        )
                        .padding(.vertical, 2)
                    }
                    
                    if entryRepo.estimateMileageAtTheEndOfYear != 0 {
                        EstimationCell(
                            value: entryRepo.estimateMileageAtTheEndOfYear,
                            unit: "km",
                            desc: "Estimation du kilomètrage à la fin de l'année"
                        )
                        .padding(.vertical, 2)
                    }
                    
                    if entryRepo.estimateMileageToTheEndOfYear != 0 {
                        EstimationCell(
                            value: entryRepo.estimateMileageToTheEndOfYear,
                            unit: "km",
                            desc: "Estimation des kilomètres qui seront fait jusqu'a la fin de l'année"
                        )
                        .padding(.vertical, 2)
                    }
                    
                }
                .padding([.horizontal, .top])
            }
            
            if !entryRepo.entries.isEmpty {
                VStack {
                    Button(action: { router.pushHistory() }, label: {
                        HStack {
                            Text("Dépenses récentes")
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color.label)
                            Spacer()
                            Image(systemName: "arrow.right")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color.customYellow)
                        }
                    })
                    
                    ForEach(entryRepo.entries.prefix(5)) { entry in
                        EntryCellView(entry: entry)
                            .padding(.vertical, 2)
                    }
                    
                    Rectangle()
                        .frame(height: 50)
                        .foregroundStyle(Color.clear)
                }
                .padding()
            } else {
                EmptyDataView(
                    image: .fuelStation,
                    title: "Vous n’avez fait aucune entrée pour l’instant",
                    actionTitle: "Ajouter une entrée",
                    action: { router.presentCreateNewEntry() }
                )
                .padding(.top)
            }
        }
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.Apple.background.ignoresSafeArea())
        .overlay(alignment: .bottom) {
            Button(action: { router.presentCreateNewEntry() }, label: {
                Circle()
                    .frame(width: 58, height: 58)
                    .foregroundStyle(Color.customYellow)
                    .overlay {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 24, weight: .semibold, design: .rounded))
                    }
            })
            .padding(.bottom)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Barrel")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
            }
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {  } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundStyle(Color.label)
                }
            }
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    NavigationStack {
        HomeView(router: .init(isPresented: .constant(nil)))
            .preferredColorScheme(.dark)
    }
}
