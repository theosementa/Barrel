//
//  CreateNewEntryViewModel.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import Foundation

@Observable
final class CreateNewEntryViewModel {
    let viewContext = PersistenceController.shared.container.viewContext
    
    var price: String = ""
    var mileage: String = ""
    var litres: String = ""
    var date: Date = .now
    
    var presentingConfirmationDialog: Bool = false
    var showAlertEssentialPro: Bool = false
    
    var entries: [EntryEntity] = []
    
}

extension CreateNewEntryViewModel {
    
    func createNewEntry() {
        let newEntry = EntryEntity(context: viewContext)
        newEntry.id = UUID()
        newEntry.price = price.convertToDouble()
        newEntry.mileage = Int64(mileage.convertToInt())
        newEntry.litres = litres.convertToDouble()
        newEntry.date = date
        
        PersistenceController.shared.saveContext()
        
        EntryManager.shared.fetchEntries()
    }
    
}

extension CreateNewEntryViewModel {
    
    func fetchEntries() {
        let request = EntryEntity.fetchRequest()
        do {
            self.entries = try viewContext.fetch(request)
        } catch {
            print("⚠️ Fail to fetch entries : \(error.localizedDescription)")
        }
    }
    
    func isEntryInCreation() -> Bool {
        if price.convertToDouble() != 0 || mileage.convertToInt() != 0 || litres.convertToDouble() != 0 {
            return true
        }
        return false
    }
    
    func isEntryValid() -> Bool {
        if entries.isEmpty { fetchEntries() }
        
        if let lastEntry = entries.sorted(by: { $0.date > $1.date }).first {
            if price.convertToDouble() != 0
                && litres.convertToDouble() != 0
                && mileage.convertToInt() != 0
                && mileage.convertToInt() > lastEntry.mileage {
                return true
            }
        } else {
            if price.convertToDouble() != 0 && litres.convertToDouble() != 0 && mileage.convertToInt() != 0 {
                return true
            }
        }
        return false
    }
    
}
