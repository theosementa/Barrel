//
//  SignInView.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import SwiftUI

struct SignInView: View {
    
    // Environment
    @EnvironmentObject private var appManager: AppManager
    @EnvironmentObject private var networkManager: NetworkManager
    @EnvironmentObject private var userRepository: UserRepository
    
    @StateObject private var viewModel: SignInViewModel = .init()
    
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
            VStack(spacing: 8) {
                CreateButton(text: "Me connecter") {
                    Task {
                        await userRepository.login(body: .init(username: viewModel.username, password: viewModel.password))
                        if userRepository.currentUser != nil {
                            appManager.state = .success
                        }
                    }
                }
                
            }
        }
        .padding()
        .navigationTitle("Connexion")
    } // body
} // struct

// MARK: - Preview
#Preview {
    NavigationStack { SignInView() }
        .environmentObject(NetworkManager())
        .environmentObject(UserRepository())
        .environmentObject(AppManager())
}
