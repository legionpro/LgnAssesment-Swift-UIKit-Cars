//
//  ItemListModelProtocol.swift
//  iOS
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import Foundation

//describes interface for ItemListModel
protocol ItemListModelProtocol {
    var itemsList: [ItemDataModel] { get set }
}
