//
//  BannerManager.swift
//  Ocerall
//
//  Created by KaayZenn on 27/06/2024.
//

import Foundation

class BannerManager: ObservableObject {
    static let shared = BannerManager()
    
    @Published var banner: Banner? = nil
}
