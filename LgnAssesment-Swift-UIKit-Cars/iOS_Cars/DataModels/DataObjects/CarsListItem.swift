//
//  CarsListItem.swift
//  iOS-Cars
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import Foundation

// MARK: - CarsListItem
struct CarsListItem: Codable {
    var id: Int?
    var make: String?
    var model: String?
    var price: Int?
    var firstRegistration: String?
    var mileage: Int?
    var fuel: String?
    var images: [CarImage]?
    var description: String?
    var modelline: String?
    var seller: CarSeller?
    var colour: String?
    
    init() {
        
    }

}
