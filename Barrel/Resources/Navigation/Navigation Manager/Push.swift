//
//  Push.swift
//  NavigationTemplate
//
//  Created by Theo Sementa on 05/07/2024.
//

import Foundation
import SwiftUI

extension NavigationManager {
    
    func pushSignIn() {
        navigateTo(.signIn)
    }
    
    func pushSignUp() {
        navigateTo(.signUp)
    }
    
    func pushCarDetail(car: CarModel) {
        navigateTo(.carDetail(car: car))
    }
}
