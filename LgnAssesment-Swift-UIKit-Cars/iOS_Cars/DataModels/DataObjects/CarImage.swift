//
//  CarImage.swift
//  iOS-Cars
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import Foundation

// MARK: - CarImage
struct CarImage: Codable, Hashable {
    var url: String? = ""
    
    enum CodingKeys: String, CodingKey {
      case url = "url"
    }
    
    init() {
        
    }
    
}
