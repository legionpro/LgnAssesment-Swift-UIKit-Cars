//
//  CarSeller.swift
//  iOS-Cars
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import Foundation


// MARK: - CarSeller
struct CarSeller: Codable {
    var type: String? = ""
    var phone: String? = ""
    var city: String? = ""

    enum CodingKeys: String, CodingKey {
      case type = "type"
      case phone = "phone"
      case city = "city"
    
    }
    
    init() {

    }
}
