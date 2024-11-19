//
//  StockHoldinglTableViewCell.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import UIKit

class StockHoldinglTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "StockHoldingCell"
    
    private lazy var stockNameView: StockNameAndStatusView = {
        let view = StockNameAndStatusView()
        view.configView(with: "ICICI", isT1HoldingStock: true)
        view.translatesAutoresizingMaskIntoConstraints = false
    
        return view
    }()

    private lazy var stockLastTradePriceView: StockValueView = {
        let view = StockValueView()
        view.translatesAutoresizingMaskIntoConstraints = false
    
        return view
    }()

    private lazy var stockNameAndLastTradePriceStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [stockNameView, stockLastTradePriceView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var stockQtyView: StockQuantityView = {
        let view = StockQuantityView()
        view.translatesAutoresizingMaskIntoConstraints = false
    
        return view
    }()

    private lazy var stockProfitAndLossView: StockValueView = {
        let view = StockValueView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configView(with: "P&L", numericValue: 12.90, shouldHighlightNumericValue: true)
    
        return view
    }()

    private lazy var stockQtyAndProfitLossStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [stockQtyView, stockProfitAndLossView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [stockNameAndLastTradePriceStackView, stockQtyAndProfitLossStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UXSpacing.threeX
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var dividerView: DividerView = {
        let view = DividerView(height: 1, horizontalSpacing: 0, color: .systemGray5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(mainStackView)
        self.contentView.addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UXSpacing.twoX),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UXSpacing.twoX),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UXSpacing.twoX),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UXSpacing.twoX),
            
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configView(with viewData: StockHoldingCellViewData) {
        stockNameView.configView(with: viewData.stockName, isT1HoldingStock: false)
        stockLastTradePriceView.configView(with: String(localized: "ltpKey"), numericValue: viewData.ltp)
        stockProfitAndLossView.configView(with: String(localized: "plkey"), numericValue: viewData.pL, shouldHighlightNumericValue: true)
        stockQtyView.configView(with: viewData.qty)
    }
}
