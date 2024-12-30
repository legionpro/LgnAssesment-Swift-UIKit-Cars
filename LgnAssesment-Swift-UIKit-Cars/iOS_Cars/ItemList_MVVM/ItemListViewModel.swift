//
//  ItemListViewModel.swift
//  iOS
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import Foundation
import Combine

class ItemListViewModel {

    var bag = Set<AnyCancellable>()
    let networkService: NetworkServiceProtocol
    @Published var model: ItemListModelProtocol
    
    init(model: ItemListModelProtocol, networkService: NetworkServiceProtocol) {
        self.model = model
        self.networkService = networkService
    }
    
    
}

extension ItemListViewModel{
    var itemsList: [ItemDataModel] {
        get { self.model.itemsList }
    }
}

extension ItemListViewModel : ItemDataMapperProtocol {
    
    func resetItemsList() {
        let pub: AnyPublisher<CarsList, APIError> = self.networkService.request(Endpoint.justGet, headers: nil, parameters: nil )
        let _ = pub
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                  print("All the requests are done")
                case .failure(let apiError):
                  print("An API error caused a problem \(apiError)")
                }
            } receiveValue: { [self] results in
                Task {
                    if let res = results as? CarsList {
                          self.model.itemsList = await self.itemResponseToItem(res)
                      }
                  }
              }
              .store(in: &bag)
    }
}
