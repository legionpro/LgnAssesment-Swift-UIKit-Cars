//
//  ItemViewModel.swift
//  iOS
//
//  Created by Oleh Poremskyy on 04.06.2024.
//

import Foundation

class ItemViewModel {
    private var model: ItemModelProtocol
    
    init(model: ItemModelProtocol) {
        self.model = model
    }
    
}


extension ItemViewModel {
    var item: ItemDataModel {
        get { self.model.itemData }
    }
}
