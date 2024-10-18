//
//  Present.swift
//  NavigationTemplate
//
//  Created by Theo Sementa on 05/07/2024.
//

import Foundation

extension NavigationManager {
    
    func presentCarDetail(car: CarModel, dismissAction: (() -> Void)? = nil) {
        presentSheet(.detail(car: car), dismissAction)
    }

    
}
