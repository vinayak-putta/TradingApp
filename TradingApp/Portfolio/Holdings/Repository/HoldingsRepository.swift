//
//  HoldingsRepository.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import Foundation

final class HoldingsRepository: BaseRepository, HoldingRepositoryProtocol {
    
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
        super.init(decoder: DataDecoder())
        
    }
    
    func fetchAllHolding(completion: @escaping (Result<[Stock], APIError>) -> Void) {
        let endpointURL = baseURL?.appending(path: "")
        
        NetworkManager.fetchData(with: httpClient, urlString: endpointURL?.absoluteString) { dataResponse in
            self.dataDecoder.decodeData(as: HoldingsResponse.self, for: dataResponse) { decodedData in
                switch decodedData {
                case .success(let data):
                    completion(.success(data.data.userHolding))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

class BaseRepository {
    public let dataDecoder: DataDecoder
    public let baseURL = URL(string: "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io")
    
    init(decoder: DataDecoder = DataDecoder()) {
        self.dataDecoder = decoder
    }
}
