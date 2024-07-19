//
//  MyVehiculeView.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import SwiftUI

struct MyVehiculeView: View {
    
    // Builder
    var router: NavigationManager
    
    // Custom
    @Bindable var vehicleSheetManager = VehicleSheetManager.shared
    
    // Environment
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: -
    var body: some View {
        ScrollView {
            if let vehicleSheet = vehicleSheetManager.vehicleSheet {
                VStack(spacing: 16) {
                    VehicleSheetCellView(
                        title: "Marque",
                        text: vehicleSheet.brand
                    )
                    
                    VehicleSheetCellView(
                        title: "Modèle",
                        text: vehicleSheet.model
                    )
                }
                .padding()
                
                VStack(spacing: 16) {
                    if vehicleSheet.hasPower() {
                        VehicleSheetCellView(
                            title: "Puissance",
                            text: vehicleSheet.power.formatted(),
                            unit: "ch"
                        )
                    }
                    
                    if vehicleSheet.hasFiscalPower() {
                        VehicleSheetCellView(
                            title: "Puissance fiscale",
                            text: vehicleSheet.fiscalPower.formatted(),
                            unit: "cv"
                            
                        )
                    }
                    
                    if vehicleSheet.hasTorque() {
                        VehicleSheetCellView(
                            title: "Couple moteur",
                            text: vehicleSheet.torque.formatted(),
                            unit: "Nm"
                        )
                    }
                    
                    if vehicleSheet.hasTankCapacity() {
                        VehicleSheetCellView(
                            title: "Taille du réservoir",
                            text: vehicleSheet.tankCapacity.formatted(),
                            unit: "L"
                        )
                    }
                }
                .padding()
                
                VStack(spacing: 16) {
                    if vehicleSheet.hasVIN() {
                        VehicleSheetCellView(
                            title: "VIN",
                            text: vehicleSheet.vin
                        )
                    }
                    
                    VehicleSheetCellView(
                        title: "Immatriculation",
                        text: vehicleSheet.immatriculation
                    )
                    
                    if let dateFirstEntryIntoCirculation = vehicleSheet.dateFirstEntryIntoCirculation {
                        VehicleSheetCellView(
                            title: "Première mise en circulation",
                            text: dateFirstEntryIntoCirculation.formatted(date: .numeric, time: .omitted)
                        )
                    }
                    
                    if let dateTechnicalControl = vehicleSheet.dateTechnicalControl {
                        VehicleSheetCellView(
                            title: "Contrôle technique",
                            text: dateTechnicalControl.formatted(date: .numeric, time: .omitted)
                        )
                    }
                }
                .padding()
            }
        } // End SrollView
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if vehicleSheetManager.vehicleSheet == nil {
                EmptyDataView(
                    image: .car,
                    title: "La fiche de votre véhicule n’est pas créée",
                    actionTitle: "Créer une fiche",
                    action: { router.presentCreateVehicleSheet() }
                )
            }
        }
        .navigationTitle("Mon véhicule")
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
            
            if let vehicleSheet = vehicleSheetManager.vehicleSheet {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button(action: {
                            router.presentEditVehicleSheet(vehicleSheet: vehicleSheet)
                        }, label: {
                            Label("Modifier", systemImage: "pencil")
                        })
                        Button(role: .destructive, action: {
                            DispatchQueue.main.async {
                                vehicleSheetManager.vehicleSheet = nil
                                viewContext.delete(vehicleSheet)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    try? viewContext.save()
                                }
                            }
                        }, label: {
                            Label("Supprimer", systemImage: "trash")
                        })
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.label)
                    }
                }
            }
        }
        .onAppear {
            vehicleSheetManager.fetchVehicleSheet()
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    MyVehiculeView(router: .init(isPresented: .constant(nil)))
}
