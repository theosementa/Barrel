//
//  CreateNewVehicleSheetViewModel.swift
//  Barrel
//
//  Created by KaayZenn on 27/04/2024.
//

import Foundation

@Observable
final class CreateNewVehicleSheetViewModel {
    let viewContext = PersistenceController.shared.container.viewContext
    
    var vehicleSheet: VehicleSheetEntity?
    
    var brand: String = ""
    var model: String = ""
    
    var power: String = ""
    var fiscalPower: String = ""
    var torque: String = ""
    var tankCapacity: String = ""
    
    var vin: String = ""
    var immatriculation: String = ""
    
    var dateFirstEntryIntoCirculation: Date = Date()
    var dateTechnicalControl: Date = Date()
    
    var isFirstStep: Bool = true
    var isDateFirstEntryIntoCirculationEnabled: Bool = false
    var isDateTechnicalControlEnabled: Bool = false
    
    var presentingConfirmationDialog: Bool = false
    
    init(vehicleSheet: VehicleSheetEntity? = nil) {
        self.vehicleSheet = vehicleSheet
        self.setup()
    }
    
}

extension CreateNewVehicleSheetViewModel {
    
    func setup() {
        if let vehicleSheet {
            self.brand = vehicleSheet.brand
            self.model = vehicleSheet.model
            self.power = vehicleSheet.power != 0 ? vehicleSheet.power.formatted() : ""
            self.fiscalPower = vehicleSheet.fiscalPower != 0 ? vehicleSheet.fiscalPower.formatted() : ""
            self.torque = vehicleSheet.torque != 0 ? vehicleSheet.torque.formatted() : ""
            self.tankCapacity = vehicleSheet.tankCapacity != 0 ? vehicleSheet.tankCapacity.formatted() : ""
            self.vin = vehicleSheet.vin
            self.immatriculation = vehicleSheet.immatriculation
            self.dateFirstEntryIntoCirculation = vehicleSheet.dateFirstEntryIntoCirculation ?? .now
            self.dateTechnicalControl = vehicleSheet.dateTechnicalControl ?? .now
            
            if vehicleSheet.dateFirstEntryIntoCirculation != nil {
                isDateFirstEntryIntoCirculationEnabled = true
            }
            
            if vehicleSheet.dateTechnicalControl != nil {
                isDateTechnicalControlEnabled = true
            }
        }
    }
    
    func isSheetInCreation() -> Bool {
        if !brand.isEmpty || !model.isEmpty || !power.isEmpty || !fiscalPower.isEmpty || !torque.isEmpty || !tankCapacity.isEmpty || !vin.isEmpty || !immatriculation.isEmpty {
            return true
        } else { return false }
    }
    
    func isFirstStepValid() -> Bool {
        if !brand.isEmpty && !model.isEmpty {
            return true
        } else { return false }
    }
    
    func isSecondStepValid() -> Bool {
        return !immatriculation.isEmpty
    }
    
    func isSheetValid() -> Bool {
        return isFirstStepValid() && isSecondStepValid()
    }
    
    func createNewVehicleSheet() {
        if let vehicleSheet {
            updateVehicleSheet(vehicleSheet: vehicleSheet)
        } else {
            let newVehicleSheet = VehicleSheetEntity(context: viewContext)
            newVehicleSheet.id = UUID()
            
            newVehicleSheet.brand = brand
            newVehicleSheet.model = model
            
            newVehicleSheet.power = Int16(power.toInt())
            newVehicleSheet.fiscalPower = Int16(fiscalPower.toInt())
            newVehicleSheet.torque = Int16(torque.toInt())
            newVehicleSheet.tankCapacity = Int16(tankCapacity.toInt())
            
            newVehicleSheet.vin = vin
            newVehicleSheet.immatriculation = immatriculation
            newVehicleSheet.dateFirstEntryIntoCirculation = isDateFirstEntryIntoCirculationEnabled ? dateFirstEntryIntoCirculation : nil
            newVehicleSheet.dateTechnicalControl = isDateTechnicalControlEnabled ? dateTechnicalControl : nil
        }
        
        try? viewContext.save()
        
        VehicleSheetManager.shared.fetchVehicleSheet()
    }
    
    private func updateVehicleSheet(vehicleSheet: VehicleSheetEntity) {
        vehicleSheet.brand = brand
        vehicleSheet.model = model
        
        vehicleSheet.power = Int16(power.toInt())
        vehicleSheet.fiscalPower = Int16(fiscalPower.toInt())
        vehicleSheet.torque = Int16(torque.toInt())
        vehicleSheet.tankCapacity = Int16(tankCapacity.toInt())
        
        vehicleSheet.vin = vin
        vehicleSheet.immatriculation = immatriculation
        vehicleSheet.dateFirstEntryIntoCirculation = isDateFirstEntryIntoCirculationEnabled ? dateFirstEntryIntoCirculation : nil
        vehicleSheet.dateTechnicalControl = isDateTechnicalControlEnabled ? dateTechnicalControl : nil
    }
}
