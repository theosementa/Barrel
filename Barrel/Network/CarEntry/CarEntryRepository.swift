//
//  CarEntryRepository.swift
//  Barrel
//
//  Created by Theo Sementa on 21/10/2024.
//

import Foundation

final class CarEntryRepository: ObservableObject {
    static let shared = CarEntryRepository()
}

extension CarEntryRepository {
    
    @MainActor
    func createEntry(carID: Int, body: CarEntry) async throws -> CarModel {
        let car = try await NetworkService.shared.sendRequest(
            apiBuilder: CarEntryAPIRequester.create(carID: carID, body: body),
            responseModel: CarModel.self
        )
        
        return car
    }
    
}
