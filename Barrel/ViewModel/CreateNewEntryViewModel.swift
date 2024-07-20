//
//  CreateNewEntryViewModel.swift
//  Barrel
//
//  Created by KaayZenn on 22/04/2024.
//

import Foundation

final class CreateNewEntryViewModel: ObservableObject {
    let entryRepo: EntryRepository = .shared
    
    @Published var price: String = ""
    @Published var mileage: String = ""
    @Published var litres: String = ""
    @Published var date: Date = .now
    
    @Published var presentingConfirmationDialog: Bool = false
    @Published var showAlertEssentialPro: Bool = false
}

extension CreateNewEntryViewModel {
    
    func createNewEntry() async {
        if let body = generateBody() {
            await entryRepo.createEntry(body: body)
        }
    }
    
    func generateBody() -> EntryBody? {
        if isEntryValid() {
            return .init(
                price: price.toDouble(),
                mileage: mileage.convertToInt(),
                liters: litres.toDouble(),
                dateIso: date.toISO8601String()
            )
        } else { return nil }
    }
    
}

extension CreateNewEntryViewModel {
    
    func isEntryInCreation() -> Bool {
        if price.convertToDouble() != 0 || mileage.convertToInt() != 0 || litres.convertToDouble() != 0 {
            return true
        }
        return false
    }
    
    func isEntryValid() -> Bool {
        if let lastEntry = entryRepo.entries.sorted(by: { $0.date ?? .now > $1.date ?? .now }).first {
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
