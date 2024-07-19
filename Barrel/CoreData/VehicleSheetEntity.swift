//
//  VehicleSheetEntity+CoreDataProperties.swift
//  Barrel
//
//  Created by KaayZenn on 27/04/2024.
//
//

import Foundation
import CoreData


@objc(VehicleSheetEntity)
public class VehicleSheetEntity: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<VehicleSheetEntity> {
        return NSFetchRequest<VehicleSheetEntity>(entityName: "VehicleSheetEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var brand: String
    @NSManaged public var model: String
    @NSManaged public var power: Int16
    @NSManaged public var fiscalPower: Int16
    @NSManaged public var torque: Int16
    @NSManaged public var tankCapacity: Int16
    @NSManaged public var vin: String
    @NSManaged public var immatriculation: String
    @NSManaged public var dateFirstEntryIntoCirculation: Date?
    @NSManaged public var dateTechnicalControl: Date?

}

extension VehicleSheetEntity {
    
    static var preview: VehicleSheetEntity {
        let preview = VehicleSheetEntity(context: PersistenceController.shared.container.viewContext)
        preview.id = UUID()
        
        preview.brand = "Preview Brand"
        preview.model = "Preview Model"
        
        preview.power = 184
        preview.fiscalPower = 10
        preview.torque = 380
        preview.tankCapacity = 55
        
        preview.vin = "123456789AZERTY"
        preview.immatriculation = "AB-123-AB"
        preview.dateFirstEntryIntoCirculation = .now
        preview.dateTechnicalControl = .now
        
        return preview
    }
    
}

extension VehicleSheetEntity {
    
    func hasPower() -> Bool {
        return power != 0
    }
    
    func hasFiscalPower() -> Bool {
        return fiscalPower != 0
    }
    
    func hasTorque() -> Bool {
        return torque != 0
    }
    
    func hasTankCapacity() -> Bool {
        return tankCapacity != 0
    }
    
    func hasVIN() -> Bool {
        return !vin.isEmpty
    }
    
}

extension VehicleSheetEntity {
    
    func dateOfTheNextTechnicalControl() -> Date? {
        guard let dateTechnicalControl else { return nil }
        
        let calendar = Calendar.current
        
        var comps = calendar.dateComponents([.day, .month, .year], from: dateTechnicalControl)
        comps.year = (comps.year ?? 0) + 2
        
        return calendar.date(from: comps)
    }
    
    func daysRemainingBeforeTheNextTechnicalControl() -> Int {
        guard let nextDate = dateOfTheNextTechnicalControl() else { return 0 }
        
        let calendar = Calendar.current
        
        let startComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        let endComponents = calendar.dateComponents([.year, .month, .day], from: nextDate)
        
        guard let startDate = calendar.date(from: startComponents),
              let endDate = calendar.date(from: endComponents) else {
            return 0
        }
        
        let numberOfDays = calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        
        return abs(numberOfDays)
    }
    
}
