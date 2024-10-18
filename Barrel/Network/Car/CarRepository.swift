//
//  CarRepository.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import Foundation

final class CarRepository: ObservableObject {
    static let shared = CarRepository()
    
    @Published var cars: [CarModel] = []
    
#if DEBUG
    init() {
        cars = [.preview]
    }
#endif
}

extension CarRepository {
    
    @MainActor
    func fetchCars() async {
        do {
            let cars = try await NetworkService.shared.sendRequest(
                apiBuilder: CarAPIRequester.getCars,
                responseModel: [CarModel].self
            )
            self.cars = cars
        } catch {
            
        }
    }
    
    @MainActor
    func createCar(body: CarModel) async {
        do {
            let car = try await NetworkService.shared.sendRequest(
                apiBuilder: CarAPIRequester.createCar(body: body),
                responseModel: CarModel.self
            )
            self.cars.append(car)
        } catch {
            
        }
    }
    
    @MainActor
    func deleteCar(id: Int) async {
        do {
            try await NetworkService.shared.sendRequest(
                apiBuilder: CarAPIRequester.deleteCar(id: id)
            )
            self.cars.removeAll(where: { $0.id == id })
        } catch {
            
        }
    }
    
}
