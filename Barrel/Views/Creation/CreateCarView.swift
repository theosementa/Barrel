//
//  CreateCarView.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import SwiftUI

struct CreateCarView: View {
    
    @StateObject private var viewModel: CreateCarViewModel = .init()
    @EnvironmentObject private var carRepository: CarRepository
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: -
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(
                    text: $viewModel.carName,
                    config: .init(
                        placeholder: "Nom de la voiture"
                    )
                )
                
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
                            await carRepository.createCar(body: .init(name: viewModel.carName))
                            dismiss()
                        }
                    } label: {
                        Text("Créer")
                            .fontWeight(.semibold)
                    }
                    .disabled(viewModel.carName.isEmpty)
                }
            }
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    Text("")
        .sheet(isPresented: .constant(true)) {
            CreateCarView()
        }
}
