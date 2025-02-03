//
//  ItemDataMapperProtocol.swift
//  iOS
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import Foundation

// MARK: - jsut protocol for mapping  response data to items

protocol ItemDataMapperProtocol {
    func itemResponseToItem(_ response: CarsList?) -> [ItemDataModel]
}

// FIXME: - needs real implematation
extension ItemDataMapperProtocol {
    func itemResponseToItem(_ response: CarsList?) -> [ItemDataModel] {
        var result: [ItemDataModel] = []
        if let resp = response {
            for item in resp {
                let element: ItemDataModel = ItemDataModel(
                        id: item.id,
                        name: item.model,
                        model: item.make,
                        description: item.description,
                        price: String(item.price ?? 0),
                        fRegistration: item.firstRegistration,
                        fuel: item.fuel,
                        webImageUrls: item.images ?? [CarImage]()
                    )
                result.append(element)
            }
        }
        return result
    }
}
