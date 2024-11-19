//
//  NetworkManager.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import Foundation

final class NetworkManager {

    static func fetchData(with httpClient: HTTPClientProtocol, urlString: String?, isNetworkOnlyRequest: Bool = false, completion: @escaping (Result<Data, APIError>) -> Void) {
        guard let urlString,
              let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Check data in cache
        if !isNetworkOnlyRequest {
            let (data, response) = handleCacheRequest(with: url)
            if let data,
               let response, response.statusCode == 200 {
                print("Debug: Fetched from cached")
                completion(.success(data))
                return
            }
        }

        
        let dataTask = httpClient.fetchData(with: url) { data, response, error in
            if let error {
                completion(.failure(.unknownError(description: error.localizedDescription)))
                return
            }
            
            do {
                // validate response
                try validateResponse(response)
            } catch {
                if let apiError = error as? APIError {
                    completion(.failure(apiError))
                    return
                } else {
                    completion(.failure(.unknownError(description: error.localizedDescription)))
                    return
                }
            }
            
            guard let data else {
                completion(.failure(APIError.unknownError(description: "Data cannot be nil")))
                return
            }
            completion(.success(data))
            
            // Store data in cache
            if !isNetworkOnlyRequest {
                CacheManager.shared.setObject(object: data, forKey: url.absoluteString)
            }
        }
        
        dataTask.resume()
    }
    
    private static func validateResponse(_ response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.responseError(description: "Failed to cast response to HTTPURLResponse")
        }
        let validRange = (200..<300)
        if !validRange.contains(httpResponse.statusCode)  {
            throw APIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
    }
    
    private static func handleCacheRequest(with url: URL) -> (Data?, HTTPURLResponse?){
        let data = CacheManager.shared.object(forKey: url.absoluteString)
        let isFaliedRequest = data == nil ? true : false
        let response = createURLRespone(With: url, isFaliedRequest: isFaliedRequest)
        return (data, response)
    }

    private static func createURLRespone(With url: URL, isFaliedRequest: Bool = false) -> HTTPURLResponse? {
        let statusCode = isFaliedRequest ? 404 : 200

        return HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: "https",
            headerFields: nil)
    }
    
}
