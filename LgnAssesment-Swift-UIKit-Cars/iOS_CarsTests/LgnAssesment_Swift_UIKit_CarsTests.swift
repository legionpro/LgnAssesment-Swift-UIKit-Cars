//
//  LgnAssesment_Swift_UIKit_CarsTests.swift
//  LgnAssesment-Swift-UIKit-CarsTests
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import XCTest
@testable import iOS_Cars
import Combine

final class LgnAssesment_Swift_UIKitTests: XCTestCase {
    
    var testService: NetworkServiceProtocol = NetworkServiceTest()
    var testModel: ItemListModelProtocol = ItemListModel()
    var itemListViewModel: ItemListViewModel? = nil

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        itemListViewModel = ItemListViewModel(model: testModel, networkService: testService)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataMaping() throws {
        itemListViewModel!.resetItemsList()
        let expectation = XCTestExpectation(description: "Open a file asynchronously.")
        DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: {
            if self.itemListViewModel!.model.itemsList.count == 10 {
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


final class NetworkServiceTest: NetworkServiceProtocol {
    @Published var cpub: CarsList?

    init() {
        cpub = createData()
    }
    func request<T>(_ endpoint: iOS_Cars.Endpoint, headers: [String : String]?, parameters: (any Encodable)?) -> AnyPublisher<T, iOS_Cars.APIError> where T : Decodable {
        let p = (cpub) as! T
        return Just(p).setFailureType(to: iOS_Cars.APIError.self).eraseToAnyPublisher()
    }
    
    func createData() -> CarsList {
        var objectsArray: [CarsListItem] = [CarsListItem]()
        for i in 0..<10 {
            var aObj = CarsListItem()
            aObj.id = 1
            aObj.make = "make"
            aObj.price = 100
            aObj.firstRegistration = ""
            aObj.mileage = 0
            aObj.fuel = "fuel"
            aObj.images = [CarImage()]
            aObj.description = "description"
            aObj.modelline = "modelline"
            aObj.seller = CarSeller()
            aObj.colour = ""
            objectsArray.append(aObj)
        }
        return  objectsArray
    }
}
