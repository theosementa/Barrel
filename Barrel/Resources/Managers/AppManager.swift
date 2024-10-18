//
//  AppManager.swift
//  TCO
//
//  Created by Theo Sementa on 02/10/2024.
//

import Foundation

final class AppManager: ObservableObject {
    static let shared = AppManager()
    
    @Published var state: ViewState = .idle
}
