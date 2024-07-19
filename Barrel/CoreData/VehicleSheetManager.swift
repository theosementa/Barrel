//
//  VehicleSheetManager.swift
//  Barrel
//
//  Created by KaayZenn on 27/04/2024.
//

import Foundation

@Observable
final class VehicleSheetManager {
    static let shared = VehicleSheetManager()
    let viewContext = PersistenceController.shared.container.viewContext
    
    var vehicleSheet: VehicleSheetEntity? = nil
}

extension VehicleSheetManager {
    
    func fetchVehicleSheet() {
        let request = VehicleSheetEntity.fetchRequest()
        do {
            let results = try viewContext.fetch(request)
            if let first = results.first {
                self.vehicleSheet = first
            }
        } catch {
            print("⚠️ Fail to fetch vehicleSheet : \(error.localizedDescription)")
        }
    }
    
}
