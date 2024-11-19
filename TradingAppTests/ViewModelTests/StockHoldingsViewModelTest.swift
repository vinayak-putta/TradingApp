//
//  ViewModelTests.swift
//  TradingAppTests
//
//  Created by Vinayak Ganesh Putta on 20/11/24.
//

import XCTest
@testable import TradingApp

final class StockHoldingsViewModelTest: XCTestCase {
    
    func testfetchHoldingListSuccess() throws {
        let urlString = "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/"
        let networkStore = MockNetworkStore()
        networkStore.stub(url: urlString, for: StockHoldings.data)
        let mockClient = MockHTTPClient(networkStore: networkStore)
        let decoder = DataDecoder()
        let viewModel = StockHoldingsViewModel(repository: HoldingsRepository(httpClient: mockClient))
        
        let expectation = XCTestExpectation(description: "CoinDataService fetch coin list")
        
        viewModel.fetchALLHoldings(completion: { result in
            switch result {
            case .success(let data):
                XCTAssertTrue(data.count > 0)
            case .failure(let error):
                XCTFail("Error should be nil: - \(error.apiErrorString)")
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation])
    }
}
