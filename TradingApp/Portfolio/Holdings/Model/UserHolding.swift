//
//  UserHolding.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import Foundation

struct HoldingsResponse: Codable {
    let data: UserStockHolding
}

struct UserStockHolding: Codable {
    let userHolding: [Stock]
}

struct Stock: Codable {
    let symbol: String
    let quantity: Int
    let ltp, avgPrice, close: Double
}

extension Stock {
    var currentValue: Double {
        ltp * Double(quantity)
    }

    var totalInvestment: Double {
        avgPrice * Double(quantity)
    }
        
    var totalProfitLoss: Double {
        currentValue - totalInvestment
    }
    
    var todaysProfitLoss: Double {
        (close - ltp) * Double(quantity)
    }
}
