//
//  CreateNewEntryView.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import SwiftUI

struct CreateNewEntryView: View {
    
    // Custom
    @StateObject private var viewModel = CreateNewEntryViewModel()
    @EnvironmentObject private var entryRepo: EntryRepository
    
    // Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: -
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    CustomTextFieldView(
                        text: $viewModel.price,
                        placeholder: "Prix (ex: 76,31)",
                        unit: "€"
                    )
                    .keyboardType(.decimalPad)
                    
                    CustomTextFieldView(
                        text: $viewModel.litres,
                        placeholder: "Litres (ex: 45,22)",
                        unit: "L"
                    )
                    .keyboardType(.decimalPad)
                    
                    CustomTextFieldView(
                        text: $viewModel.mileage,
                        placeholder: "Kilomètrage (ex: 68 072)",
                        unit: "KM",
                        lastMileage: Int(entryRepo.entries.sorted(by: { $0.date ?? .now > $1.date ?? .now }).first?.mileage ?? 0)
                    )
                    .keyboardType(.numberPad)
                    
                    HStack {
                       Text("Date")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundStyle(Color(uiColor: .placeholderText))
                        
                        Spacer()
                        
                        DatePicker("", selection: $viewModel.date, displayedComponents: .date)
                    }
                    .padding(.leading)
                    .padding(.vertical, 10)
                    .padding(.trailing, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.Apple.backgroundComponentSheet)
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Nouvelle entrée")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: {
                        Text("Annuler")
                            .foregroundStyle(Color.customYellow)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await viewModel.createNewEntry()
                            dismiss()
                        }
                    } label: {
                        Text("Enregistrer")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.customYellow)
                    }
                    .disabled(!viewModel.isEntryValid())
                    .opacity(viewModel.isEntryValid() ? 1 : 0.4)
                }
                
                ToolbarDismissKeyboardButtonView()
            }
        } // End NavigationStack
        .interactiveDismissDisabled(viewModel.isEntryInCreation()) {
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
    CreateNewEntryView()
        .preferredColorScheme(.dark)
}
