//
//  SignUpView.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import SwiftUI

struct SignUpView: View {
    
    // Environment
    @EnvironmentObject private var appManager: AppManager
    @EnvironmentObject private var networkManager: NetworkManager
    @EnvironmentObject private var router: NavigationManager
    @EnvironmentObject private var userRepository: UserRepository
    
    @StateObject private var viewModel: SignUpViewModel = .init()
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: -
    var body: some View {
        VStack(spacing: 16) {
            if networkManager.isConnected {
                CustomTextField(
                    text: $viewModel.username,
                    config: .init(
                        placeholder: "Nom d'utilisateur",
                        isAutoCapitalizationEnabled: false
                    )
                )
                CustomTextField(
                    text: $viewModel.password,
                    config: .init(
                        placeholder: "Mot de passe",
                        isSecured: true,
                        isAutoCapitalizationEnabled: false
                    )
                )
            } else {
                Text("Tu n'as pas de connexion internet.")
            }
            Spacer()
            VStack(spacing: 12) {
                CreateButton(text: "Créer mon compte") {
                    Task {
                        await userRepository.register(body: .init(username: viewModel.username, password: viewModel.password))
                        if userRepository.currentUser != nil {
                            appManager.state = .success
                            dismiss()
                        }
                    }
                }
                NavigationButton(push: router.pushSignIn()) {
                    Text("J'ai déjà un compte")
                        .font(.system(size: 12, weight: .semibold))
                }
            }
        }
        .padding()
        .navigationTitle("Inscription")
    } // body
} // struct

// MARK: - Preview
#Preview {
    NavigationStack { SignUpView() }
        .environmentObject(NetworkManager())
        .environmentObject(UserRepository())
        .environmentObject(AppManager())
}
