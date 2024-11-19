//
//  StocksHoldingDataTransformerTest.swift
//  TradingAppTests
//
//  Created by Vinayak Ganesh Putta on 20/11/24.
//

import XCTest
@testable import TradingApp

final class StocksHoldingDataTransformerTest: XCTestCase {

    var transformer: StockHoldingDataTransformer!
    
    override func setUp() {
        super.setUp()
        transformer = StockHoldingDataTransformer()
    }
    
    override func tearDown() {
        transformer = nil
        super.tearDown()
    }
    
    func testMakeProfileSummaryViewData() {
        let stocks = [
            Stock(symbol: "MAHABANK", quantity: 990, ltp: 38.05, avgPrice: 35, close: 40),
            Stock(symbol: "ICICI", quantity: 100, ltp: 118.25, avgPrice: 110, close: 105)
        ]
        

        let viewData = transformer.makeProfileSummaryViewData(from: stocks)
        
        XCTAssertEqual(viewData.currentValue, 49494.5, "Current value should match the sum of current values.")
        XCTAssertEqual(viewData.totalInvestment, 45650.0, "Total investment should match the sum of investments.")
        XCTAssertEqual(viewData.todaysProfitAndLoss, 605.50, "Today's profit and loss should match the sum of individual profits.")
        XCTAssertEqual(viewData.totalProfitAndLoss, 3844.5, "Total profit and loss should be currentValue - totalInvestment.")
        XCTAssertEqual(viewData.profitAndLossPercent, 8.42, accuracy: 0.0001, "Profit and loss percent should match the calculation.")
    }
    
    func testMakeStockHoldingCellViewData() {

        let stock = Stock(symbol: "MAHABANK", quantity: 990, ltp: 38.05, avgPrice: 35, close: 40)
        
        let cellData = transformer.makeStockHoldingCellViewData(from: stock)
        
        XCTAssertEqual(cellData.ltp, 38.05, "LTP should match the stock's last traded price.")
        XCTAssertEqual(cellData.pL, 3019.5, "Profit/Loss should be currentValue - totalInvestment.")
        XCTAssertEqual(cellData.qty, 990, "Quantity should match the stock quantity.")
    }

}
