//
//  CreateNewVehicleSheetView.swift
//  Barrel
//
//  Created by KaayZenn on 27/04/2024.
//

import SwiftUI

struct CreateNewVehicleSheetView: View {
    
    // Builder
    @Bindable var viewModel: CreateNewVehicleSheetViewModel
    
    // Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: -
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isFirstStep {
                    VStack(spacing: 16) {
                        CustomTextFieldView(
                            text: $viewModel.brand,
                            placeholder: "Marque (ex: Audi)"
                        )
                        
                        CustomTextFieldView(
                            text: $viewModel.model,
                            placeholder: "Modèle (ex: A3 Sportback)"
                        )
                    }
                    .padding()
                    
                    VStack(spacing: 16) {
                        CustomTextFieldView(
                            text: $viewModel.power,
                            placeholder: "Puissance (ex: 150)",
                            unit: "ch"
                        )
                        .keyboardType(.numberPad)
                        
                        CustomTextFieldView(
                            text: $viewModel.fiscalPower,
                            placeholder: "Puissance fiscale (ex: 7)",
                            unit: "cv"
                        )
                        .keyboardType(.numberPad)
                        
                        CustomTextFieldView(
                            text: $viewModel.torque,
                            placeholder: "Couple moteur (ex: 310)",
                            unit: "Nm"
                        )
                        .keyboardType(.numberPad)
                        
                        CustomTextFieldView(
                            text: $viewModel.tankCapacity,
                            placeholder: "Capacité du réservoir (ex: 55)",
                            unit: "L"
                        )
                        .keyboardType(.numberPad)
                    }
                    .padding()
                } else {
                    VStack(spacing: 16) {
                        CustomTextFieldView(
                            text: $viewModel.vin,
                            placeholder: "VIN (ex: 1C3CCBABXDN669146)"
                        )
                        .textInputAutocapitalization(.characters)
                        
                        CustomTextFieldView(
                            text: $viewModel.immatriculation,
                            placeholder: "Immatriculation (ex: AB-123-CD)"
                        )
                        .textInputAutocapitalization(.characters)
                        
                        if viewModel.isDateFirstEntryIntoCirculationEnabled {
                            VStack {
                                Button {
                                    viewModel.isDateFirstEntryIntoCirculationEnabled = false
                                } label: {
                                    HStack {
                                        Text("- Première mise en circulation")
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                            .foregroundStyle(Color.customYellow)
                                        Spacer()
                                    }
                                }
                                
                                HStack {
                                    Text("Première mise en circulation")
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundStyle(Color(uiColor: .placeholderText))
                                    
                                    Spacer()
                                    
                                    DatePicker("", selection: $viewModel.dateFirstEntryIntoCirculation, displayedComponents: .date)
                                        .labelsHidden()
                                }
                                .padding(.leading)
                                .padding(.vertical, 10)
                                .padding(.trailing, 10)
                                .background {
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .fill(Color.Apple.backgroundComponentSheet)
                                }
                            }
                        } else {
                            Button {
                                viewModel.isDateFirstEntryIntoCirculationEnabled = true
                            } label: {
                                HStack {
                                    Text("+ Première mise en circulation")
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundStyle(Color.customYellow)
                                    Spacer()
                                }
                            }
                        }
                        
                        if viewModel.isDateTechnicalControlEnabled {
                            VStack {
                                Button {
                                    viewModel.isDateTechnicalControlEnabled = false
                                } label: {
                                    HStack {
                                        Text("- Contrôle technique")
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                            .foregroundStyle(Color.customYellow)
                                        Spacer()
                                    }
                                }
                                
                                HStack {
                                    Text("Contrôle technique")
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundStyle(Color(uiColor: .placeholderText))
                                    
                                    Spacer()
                                    
                                    DatePicker("", selection: $viewModel.dateTechnicalControl, displayedComponents: .date)
                                        .labelsHidden()
                                }
                                .padding(.leading)
                                .padding(.vertical, 10)
                                .padding(.trailing, 10)
                                .background {
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .fill(Color.Apple.backgroundComponentSheet)
                                }
                            }
                        } else {
                            Button {
                                viewModel.isDateTechnicalControlEnabled = true
                            } label: {
                                HStack {
                                    Text("+ Contrôle technique")
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundStyle(Color.customYellow)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Nouvelle entrée")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Annuler")
                            .foregroundStyle(Color.customYellow)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if viewModel.isFirstStep {
                            withAnimation { viewModel.isFirstStep = false }
                        } else {
                            viewModel.createNewVehicleSheet()
                            dismiss()
                        }
                    } label: {
                        Text(viewModel.isFirstStep ? "Suivant" : "Enregistrer")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.customYellow)
                    }
                    .disabled(viewModel.isFirstStep ? !viewModel.isFirstStepValid() : !viewModel.isSecondStepValid())
                    .opacity((viewModel.isFirstStep ? viewModel.isFirstStepValid() : viewModel.isSecondStepValid()) ? 1 : 0.4)
                }
                
                ToolbarDismissKeyboardButtonView()
            }
        } // End NavigationStack
        .interactiveDismissDisabled(viewModel.isSheetInCreation()) {
            viewModel.presentingConfirmationDialog.toggle()
        }
        .confirmationDialog("", isPresented: $viewModel.presentingConfirmationDialog) {
            Button("Annuler les changements", role: .destructive, action: { dismiss() })
            Button("Retour", role: .cancel, action: { })
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    CreateNewVehicleSheetView(viewModel: CreateNewVehicleSheetViewModel())
}
