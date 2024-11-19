//
//  StockHoldingDataTransformer.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import Foundation

class StockHoldingDataTransformer {
    func makeProfileSummaryViewData(from stocks: [Stock]) -> PortfolioSummaryViewData {
        let currentValue = stocks.reduce(0) { $0 + $1.currentValue }
        let totalInvestMent = stocks.reduce(0) { $0 + $1.totalInvestment }
        let totalProfitAndLoss = currentValue - totalInvestMent
        let todaysProfitAndLoss = stocks.reduce(0) { $0 + $1.todaysProfitLoss }
        let profitAndLossPercent = (totalProfitAndLoss * 100) / totalInvestMent
        
        return PortfolioSummaryViewData(
            currentValue: currentValue,
            totalInvestment: totalInvestMent,
            todaysProfitAndLoss: todaysProfitAndLoss.rounded(toPlaces: 2),
            totalProfitAndLoss: totalProfitAndLoss,
            profitAndLossPercent: profitAndLossPercent.rounded(toPlaces: 2))
    }
    
    func makeStockHoldingCellViewData(from stock: Stock) -> StockHoldingCellViewData {
        let ltp = stock.ltp
        let stockName = stock.symbol
        let pL = stock.currentValue - stock.totalInvestment
        let qty = stock.quantity
        return StockHoldingCellViewData(stockName: stockName, ltp: ltp, pL: pL, qty: qty)
    }
}
