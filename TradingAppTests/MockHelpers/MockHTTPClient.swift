//
//  MockHTTPClient.swift
//  TradingAppTests
//
//  Created by Vinayak Ganesh Putta on 20/11/24.
//

import Foundation

@testable import TradingApp

class MockHTTPClient: HTTPClientProtocol {
    let networkStore: NetworkStoreProtocol
    
    init(networkStore: NetworkStoreProtocol) {
        self.networkStore = networkStore
    }
    
    func fetchData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTClientDataTaskProtocol {
        let task = MockURLSessionDataTask()
        
        // Make request
        let (data, response) = networkStore.makeRequest(with: url)
        
        // Call completion when resumed is called on task
        task.completionHander = {
            if data == nil && response == nil {
                let error = NSError()
                completionHandler(data, response, error)
            }
            completionHandler(data, response, nil)
        }
        return task
    }
}

class MockURLSessionDataTask: HTTClientDataTaskProtocol {
    var completionHander: (() -> ())?
    
    func resume() {
        completionHander?()
    }
}
