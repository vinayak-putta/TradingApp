//
//  TradingAppTests.swift
//  TradingAppTests
//
//  Created by Vinayak Ganesh Putta on 20/11/24.
//

import XCTest
@testable import TradingApp

final class NetworkManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /**
     Test for Success everything is working fine
     */
    func testFetchDataForSuccess() throws {
        let urlString = "https://www.test.com"
        let mockNetworkStore = MockNetworkStore()
        mockNetworkStore.stub(url: urlString, for: Data())
        let mockClient = MockHTTPClient(networkStore: mockNetworkStore)
        
        let exception = XCTestExpectation(description: "Data fetch Exception")
        NetworkManager.fetchData(with: mockClient, urlString: urlString) { result in
            if case .failure(let failure) = result {
                XCTFail("\(failure.apiErrorString)")
            } else {
                exception.fulfill()
            }
        }
        
        
        wait(for: [exception], timeout: 0.5)
    }
    
    /**
     Test for failure request with error - request not found when data not stubbed
     */
    func testFetchDataForFailure() throws {
        let urlString = "https://www.test.com"
        let mockNetworkStore = MockNetworkStore()
        mockNetworkStore.stub(url: urlString, for: nil)
        let mockClient = MockHTTPClient(networkStore: mockNetworkStore)
        
        let expectation = XCTestExpectation(description: "Data fetch failure Exception")
        NetworkManager.fetchData(with: mockClient, urlString: urlString, isNetworkOnlyRequest: false) { result in
            if case .failure(let failure) = result {
                XCTAssertEqual(failure.apiErrorString, APIError.invalidStatusCode(statusCode: 404).apiErrorString)
                expectation.fulfill()
            } else {
                XCTFail("API should fail")
            }
        }
        
        
        wait(for: [expectation], timeout: 0.5)
    }
}
