//
//  CacheManager.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import Foundation

class CacheManager {
    private let userDefaults = UserDefaults.standard
    private let cacheKeyPrefix = "CachedResponse_"
    private let timestampKeyPrefix = "CachedTimestamp_"
    private let cacheExpiryThreshold: TimeInterval = 600 // 10 minutes in seconds
    
    public static let shared = CacheManager()
    
    private init() {}
    
    func object(forKey key: String) -> Data? {
        let cacheKey = cacheKeyPrefix + key
        let timestampKey = timestampKeyPrefix + key
        
        guard let savedData = userDefaults.data(forKey: cacheKey),
              let savedTimestamp = userDefaults.object(forKey: timestampKey) as? Date else {
            return nil
        }
        
        let currentTime = Date()
        if currentTime.timeIntervalSince(savedTimestamp) > cacheExpiryThreshold {
            // Data expired, remove it
            userDefaults.removeObject(forKey: cacheKey)
            userDefaults.removeObject(forKey: timestampKey)
            return nil
        }
        
        return savedData
    }
    
    func setObject(object: Data, forKey key: String) {
        let cacheKey = cacheKeyPrefix + key
        let timestampKey = timestampKeyPrefix + key
    
        userDefaults.set(object, forKey: cacheKey)
        userDefaults.set(Date(), forKey: timestampKey)
    }
}

