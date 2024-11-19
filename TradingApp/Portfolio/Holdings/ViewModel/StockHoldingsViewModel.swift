//
//  HoldingsViewModel.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import Foundation

class StockHoldingsViewModel {
    private let repository: HoldingRepositoryProtocol
    
    init(repository: HoldingRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchALLHoldings(completion: @escaping (Result<[Stock], APIError>) -> Void) {
        self.repository.fetchAllHolding { response in
            switch response {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
