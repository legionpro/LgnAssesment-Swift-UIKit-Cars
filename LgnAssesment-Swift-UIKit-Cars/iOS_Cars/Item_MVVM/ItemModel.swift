//
//  ItemModel.swift
//  iOS
//
//  Created by Oleh Poremskyy on 04.06.2024.
//

import Foundation

class ItemModel {
    private var item: ItemDataModel
    
    init(item: ItemDataModel) {
        self.item = item
    }
}

extension ItemModel: ItemModelProtocol {
    var itemData: ItemDataModel {
        get { self.item }
        set { self.item = newValue }
    }

}
