//
//  HelperExtensions.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import Foundation

extension Double {
    private static var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currency
        
        return formatter
    }()

    var currencyRepresentation: String {
        return Double.currencyFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    func rounded(toPlaces places: Int) -> Double {
        let factor = pow(10.0, Double(places))
        return (self * factor).rounded() / factor
    }
}
