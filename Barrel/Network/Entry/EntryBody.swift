//
//  EntryBody.swift
//  Barrel
//
//  Created by KaayZenn on 19/07/2024.
//

import Foundation

struct EntryBody: Codable {
    var price: Double
    var mileage: Int
    var liters: Double?
    var dateIso: String
}
