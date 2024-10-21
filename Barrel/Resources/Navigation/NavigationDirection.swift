//
//  NavigationDirection.swift
//  Krabs
//
//  Created by Theo Sementa on 05/12/2023.
//

import Foundation
import SwiftUI


enum NavigationDirection: Identifiable {
        
    case signIn
    case signUp
    
    case home
    case carDetail(car: CarModel)
    case createCar
    case createEntry(car: CarModel)

    var id: Self { self }
}

extension NavigationDirection: Equatable {
    static func == (lhs: NavigationDirection, rhs: NavigationDirection) -> Bool {
        switch (lhs, rhs) {
        case (.signIn, .signIn),
            (.signUp, .signUp),
            (.home, .home),
            (.carDetail, .carDetail),
            (.createCar, .createCar),
            (.createEntry, .createEntry):
            return true

        default:
            return false
        }
    }
}

extension NavigationDirection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
