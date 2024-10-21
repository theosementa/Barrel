//
//  CreateCarEntryView.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import SwiftUI

struct CreateCarEntryView: View {
    
    // builder
    @ObservedObject var car: CarModel
    
    @StateObject private var viewModel: CreateCarEntryViewModel = .init()
    @EnvironmentObject private var carEntryRepository: CarEntryRepository
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: -
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                CustomTextField(
                    text: $viewModel.mileageField,
                    config: .init(
                        placeholder: "Kilométrage de la voiture",
                        keyboardType: .numberPad
                    )
                )
                
                CustomTextField(
                    text: $viewModel.priceField,
                    config: .init(
                        placeholder: "Prix du plein d'essence",
                        keyboardType: .decimalPad
                    )
                )
                
                CustomTextField(
                    text: $viewModel.literField,
                    config: .init(
                        placeholder: "Litres du plein d'essence",
                        keyboardType: .decimalPad
                    )
                )
                
                DatePicker("Date", selection: $viewModel.date)
                
                Text(viewModel.date.ISO8601Format())
                
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: {
                        Text("Retour")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            do {
                                if let carID = car.id {
                                    let newCarWithEntries = try await carEntryRepository.createEntry(
                                        carID: carID,
                                        body: .init(
                                            mileage: viewModel.mileageField.isEmpty ? nil : viewModel.mileageField.toInt(),
                                            price: viewModel.priceField.isEmpty ? nil : viewModel.priceField.toDouble(),
                                            liters: viewModel.literField.isEmpty ? nil : viewModel.literField.toDouble(),
                                            date: viewModel.date.ISO8601Format()
                                        )
                                    )
                                    if let last =  newCarWithEntries.entries?.last {
                                        car.entries?.append(last)
                                    }
                                }
                                dismiss()
                            } catch {
                                
                            }
                        }
                    } label: {
                        Text("Créer")
                            .fontWeight(.semibold)
                    }
                    .disabled(!viewModel.isBodyValid())
                }
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    CreateCarEntryView(car: .preview)
}
