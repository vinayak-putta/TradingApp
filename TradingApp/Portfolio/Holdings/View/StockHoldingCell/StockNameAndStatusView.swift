//
//  StockNameAndStatusView.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import UIKit

class StockNameAndStatusView: UIView {
    
    private lazy var stockNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFontMetrics(forTextStyle: .title3).scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .bold))

        return label
    }()
    
    private lazy var stockHoldingStatusView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "T1 Holding"
        label.textColor = .darkGray
        label.font = UIFontMetrics(forTextStyle: .caption2).scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .semibold))

        return label
    }()
    
    private lazy var stockHoldingStatusContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.addSubview(stockHoldingStatusView)
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var containerView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [stockNameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = UXSpacing.oneX
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            stockHoldingStatusView.topAnchor.constraint(equalTo: stockHoldingStatusContainer.topAnchor),
            stockHoldingStatusView.leadingAnchor.constraint(equalTo: stockHoldingStatusContainer.leadingAnchor, constant: UXSpacing.halfX),
            stockHoldingStatusView.trailingAnchor.constraint(equalTo: stockHoldingStatusContainer.trailingAnchor, constant: -UXSpacing.halfX),
            stockHoldingStatusView.bottomAnchor.constraint(equalTo: stockHoldingStatusContainer.bottomAnchor),
        ])
    }
    
    public func configView(with stockNameLabel: String, isT1HoldingStock: Bool = false) {
        self.stockNameLabel.text = "\(stockNameLabel)"
        if isT1HoldingStock {
            containerView.addArrangedSubview(stockHoldingStatusContainer)
        }
    }
}
