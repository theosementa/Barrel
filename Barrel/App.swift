//
//  BarrelApp.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import SwiftUI

@main
struct BarrelApp: App {
    
    let router = NavigationManager(isPresented: .constant(.home))
    
    @StateObject private var entryRepo: EntryRepository = .shared
    @StateObject private var userRepo: UserRepository = .shared
    
    @StateObject private var appManager: AppManager = .shared
    @StateObject private var bannerManager: BannerManager = .shared

    // MARK: -
    var body: some Scene {
        WindowGroup {
            NavStack(router: router) {
                switch appManager.state {
                case .idle:
                    SplashScreenView()
                case .loading:
                    SplashScreenView()
                case .success:
                    HomeView(router: router)
                case .failed:
                    Text("Error loadind data")
                }
            }
            .environmentObject(bannerManager)
            .environmentObject(entryRepo)
            .environmentObject(userRepo)
            .task {
                appManager.state = .loading
                if KeychainManager.shared.retrieveItem(service: .token) == nil {
                    await userRepo.register()
                }
                await entryRepo.fetchEntries()
            }
        }
    } // End body
} // End struct
