//
//  EntryEntity+CoreDataProperties.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//
//

import Foundation
import CoreData

@objc(EntryEntity)
public class EntryEntity: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntryEntity> {
        return NSFetchRequest<EntryEntity>(entityName: "EntryEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var price: Double
    @NSManaged public var mileage: Int64
    @NSManaged public var litres: Double
    @NSManaged public var date: Date
    
    var priceOfLitre: Double {
        return price / litres
    }

}

extension EntryEntity {
    
    static var preview: EntryEntity {
        let entry = EntryEntity(context: PersistenceController.shared.container.viewContext)
        entry.id = UUID()
        entry.price = 32.12
        entry.mileage = 67_324
        entry.litres = 23.4
        entry.date = .now
        
        return entry
    }
    
}
