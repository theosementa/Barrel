//
//  CreateCarEntryViewModel.swift
//  Barrel
//
//  Created by Theo Sementa on 21/10/2024.
//

import Foundation

final class CreateCarEntryViewModel: ObservableObject {
    @Published var mileageField: String = ""
    @Published var priceField: String = ""
    @Published var literField: String = ""
    @Published var date: Date = .init()
}

extension CreateCarEntryViewModel {
    
    func isBodyValid() -> Bool {
        if mileageField.isEmpty && priceField.isEmpty && literField.isEmpty {
            return false
        }
        return true
    }
    
}
