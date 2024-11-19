//
//  HTTPClientProtocol.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import Foundation

protocol HTTPClientProtocol {
    func fetchData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTClientDataTaskProtocol
}

protocol HTTClientDataTaskProtocol {
    func resume()
}
