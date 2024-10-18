//
//  CarAPIRequester.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import Foundation

enum CarAPIRequester: APIRequestBuilder {
    case getCars
    case createCar(body: CarModel)
    case deleteCar(id: Int)
}

extension CarAPIRequester {
    var path: String {
        switch self {
        case .getCars:              return NetworkPath.Car.get
        case .createCar:            return NetworkPath.Car.create
        case .deleteCar(let id):    return NetworkPath.Car.delete(id)
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getCars:   return .GET
        case .createCar: return .POST
        case .deleteCar: return .DELETE
        }
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
    
    var isTokenNeeded: Bool {
        return true
    }
    
    var body: Data? {
        switch self {
        case .createCar(let body):  return try? JSONEncoder().encode(body)
        default:                    return nil
        }
    }
}
