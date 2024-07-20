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
    
    @StateObject private var bannerManager: BannerManager = .shared

    // MARK: -
    var body: some Scene {
        WindowGroup {
            NavStack(router: router) {
                HomeView(router: router)
            }
            .environmentObject(bannerManager)
            .environmentObject(entryRepo)
            .environmentObject(userRepo)
            .task {
                if let token = KeychainManager.shared.retrieveItem(service: .token) {
                    print("🔥 TOKEN : \(token)")
                } else {
                    await userRepo.register()
                }
                await entryRepo.fetchEntries()
            }
        }
    } // End body
} // End struct
