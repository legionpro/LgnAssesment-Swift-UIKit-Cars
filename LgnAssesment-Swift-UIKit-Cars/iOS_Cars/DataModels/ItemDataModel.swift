//
//  ItemDataModel.swift
//  iOS
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import Foundation


//MARK: - Describes Items type for using on UI (list view)

//MARK: - ItemDataModel
struct ItemDataModel: Hashable {
    static func == (lhs: ItemDataModel, rhs: ItemDataModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let model: String
    let description: String
    let price: String
    let fRegistration: String
    let fuel: String
    let webImageUrls: [CarImage]
    
    init(id: Int?, name: String?, model: String?, description: String?, price: String?, fRegistration: String?, fuel: String?, webImageUrls: [CarImage]?) {
        self.id = id ?? 1
        self.name = name ?? "---"
        self.model = model ?? "---"
        self.description = description ?? " ... "
        self.price = price ?? " -- "
        self.fRegistration = fRegistration ?? " -- "
        self.fuel = fuel ?? " -- "
        self.webImageUrls = webImageUrls ?? []
    }
}

