//
//  HoldingRepositoryProtocol.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import Foundation

protocol HoldingRepositoryProtocol {
    func fetchAllHolding(completion: @escaping (Result<[Stock], APIError>) -> Void)
}
