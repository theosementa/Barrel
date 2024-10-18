//
//  CarEntry.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import Foundation

struct CarEntry: Codable, Identifiable {
    var id: Int?
    var mileage: Int?
    var price: Double?
    var liters: Double?
}

extension CarEntry {
    static let preview1: Self = .init(
        id: 1,
        mileage: 67800,
        price: 56.45,
        liters: 39.01
    )
    static let preview2: Self = .init(
        id: 2,
        mileage: 68600,
        price: 78.09,
        liters: 59.56
    )
    static let preview3: Self = .init(
        id: 3,
        mileage: 69200,
        price: 36.12,
        liters: 30.23
    )
}
