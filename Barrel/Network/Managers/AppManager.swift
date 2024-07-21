//
//  AppManager.swift
//  Barrel
//
//  Created by KaayZenn on 21/07/2024.
//

import Foundation

final class AppManager: ObservableObject {
    static let shared = AppManager()
    
    @Published var state: ViewState = .idle
}
