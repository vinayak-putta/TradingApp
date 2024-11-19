//
//  StockHoldings.swift
//  TradingAppTests
//
//  Created by Vinayak Ganesh Putta on 20/11/24.
//

import Foundation

class StockHoldings {
    static let data: Data? = """
    {
      "data": {
        "userHolding": [
          {
            "symbol": "MAHABANK",
            "quantity": 990,
            "ltp": 38.05,
            "avgPrice": 35,
            "close": 40
          },
          {
            "symbol": "ICICI",
            "quantity": 100,
            "ltp": 118.25,
            "avgPrice": 110,
            "close": 105
          },
          {
            "symbol": "SBI",
            "quantity": 150,
            "ltp": 550.05,
            "avgPrice": 501,
            "close": 590
          },
          {
            "symbol": "TATA STEEL",
            "quantity": 200,
            "ltp": 137,
            "avgPrice": 110.65,
            "close": 100.05
          },
          {
            "symbol": "INFOSYS",
            "quantity": 121,
            "ltp": 1305,
            "avgPrice": 1245.45,
            "close": 1103.85
          },
          {
            "symbol": "AIRTEL",
            "quantity": 415,
            "ltp": 340.75,
            "avgPrice": 370.1,
            "close": 290
          },
          {
            "symbol": "UCO BANK",
            "quantity": 2000,
            "ltp": 18.05,
            "avgPrice": 28.15,
            "close": 22.25
          },
          {
            "symbol": "NHPC",
            "quantity": 900,
            "ltp": 88.05,
            "avgPrice": 80.75,
            "close": 70.65
          },
          {
            "symbol": "SJVN",
            "quantity": 400,
            "ltp": 113.05,
            "avgPrice": 105,
            "close": 110
          },
          {
            "symbol": "PNB BANK",
            "quantity": 100,
            "ltp": 132.05,
            "avgPrice": 100,
            "close": 145.55
          },
          {
            "symbol": "RELIANCE",
            "quantity": 50,
            "ltp": 2500,
            "avgPrice": 2450,
            "close": 2600
          },
          {
            "symbol": "HDFC",
            "quantity": 75,
            "ltp": 1800.25,
            "avgPrice": 1750,
            "close": 1700
          },
          {
            "symbol": "MARUTI",
            "quantity": 30,
            "ltp": 7000,
            "avgPrice": 6800,
            "close": 7200
          },
          {
            "symbol": "TCS",
            "quantity": 150,
            "ltp": 3500,
            "avgPrice": 3400,
            "close": 3300
          },
          {
            "symbol": "HCL",
            "quantity": 200,
            "ltp": 1000,
            "avgPrice": 980,
            "close": 1050
          },
          {
            "symbol": "WIPRO",
            "quantity": 300,
            "ltp": 500,
            "avgPrice": 480,
            "close": 520
          },
          {
            "symbol": "BPCL",
            "quantity": 80,
            "ltp": 400,
            "avgPrice": 380,
            "close": 420
          },
          {
            "symbol": "HPCL",
            "quantity": 60,
            "ltp": 300,
            "avgPrice": 290,
            "close": 320
          },
          {
            "symbol": "ONGC",
            "quantity": 120,
            "ltp": 150,
            "avgPrice": 140,
            "close": 160
          },
          {
            "symbol": "IOC",
            "quantity": 200,
            "ltp": 120,
            "avgPrice": 110,
            "close": 130
          },
          {
            "symbol": "HINDALCO",
            "quantity": 150,
            "ltp": 400,
            "avgPrice": 380,
            "close": 420
          },
          {
            "symbol": "ADANI PORTS",
            "quantity": 500,
            "ltp": 800,
            "avgPrice": 780,
            "close": 820
          },
          {
            "symbol": "CIPLA",
            "quantity": 100,
            "ltp": 900,
            "avgPrice": 880,
            "close": 920
          },
          {
            "symbol": "JSW STEEL",
            "quantity": 250,
            "ltp": 600,
            "avgPrice": 580,
            "close": 620
          },
          {
            "symbol": "AXIS BANK",
            "quantity": 300,
            "ltp": 700,
            "avgPrice": 680,
            "close": 720
          }
        ]
      }
    }
    """.data(using: .utf8)
}
