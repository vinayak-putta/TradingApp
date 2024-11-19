//
//  DataDecoder.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import Foundation

class DataDecoder {
    func decodeData<T: Decodable>(
        as type: T.Type,
        for result: Result<Data, APIError>,
        completion: @escaping (Result<T, APIError>) -> Void) {
            
            switch result {
            case .success(let data):
                do {
                    let decodeData = try JSONDecoder().decode(type, from: data)
                    completion(.success(decodeData))
                } catch {
                    completion(.failure(.jsonParsing(description: error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
}
