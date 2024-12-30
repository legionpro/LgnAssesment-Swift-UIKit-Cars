//
//  ItemDataModel.swift
//  iOS
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import Foundation
import Observation


//MARK: - Data for main screen  -  Item List Controller
@Observable
class ItemListModel {
    private var items = [ItemDataModel]()
    
    func addItem(_ item: ItemDataModel) {
        self.items.append(item)
    }
}

extension ItemListModel: ItemListModelProtocol {
    var itemsList: [ItemDataModel] {
        get { self.items }
        set { self.items = newValue }
    }
}

