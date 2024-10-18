//
//  BarrelApp.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import SwiftUI

@main
struct BarrelApp: App {
    
    let router: NavigationManager = .init(isPresented: .constant(.home))
    
    @StateObject private var appManager: AppManager = .shared
    @StateObject private var networkManager: NetworkManager = .init()
    
    @StateObject private var userRepository: UserRepository = .shared
    @StateObject private var carRepository: CarRepository = .shared
    
    // MARK: -
    var body: some Scene {
        WindowGroup {
            NavStack(router: router) {
                switch appManager.state {
                case .idle:     EmptyView()
                case .loading:  EmptyView()
                case .success:  HomeView()
                case .failed:   SignUpView()
                }
            }
            .environmentObject(router)
            .environmentObject(appManager)
            .environmentObject(networkManager)
            .environmentObject(userRepository)
            .environmentObject(carRepository)
            .task {
                appManager.state = .loading
                do {
                    try await userRepository.loginWithToken()
                    appManager.state = .success
                } catch {
                    appManager.state = .failed
                }
            }
        }
    } // body
} // struct
