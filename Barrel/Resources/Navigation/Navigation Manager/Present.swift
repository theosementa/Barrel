//
//  Present.swift
//  NavigationTemplate
//
//  Created by Theo Sementa on 05/07/2024.
//

import Foundation

extension NavigationManager {
    
    func presentCreateCar(dismissAction: (() -> Void)? = nil) {
        presentSheet(.createCar, dismissAction)
    }
    
    func presentCreateEntry(car: CarModel, dismissAction: (() -> Void)? = nil) {
        presentSheet(.createEntry(car: car), dismissAction)
    }
    
}
