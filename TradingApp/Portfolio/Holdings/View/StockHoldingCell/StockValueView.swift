//
//  StockValueView.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import UIKit

class StockValueView: UIView {
    private lazy var prefixLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "LTP:"
        label.font = UIFontMetrics(forTextStyle: .caption2).scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .semibold))
        label.textColor = .systemGray2

        return label
    }()
    
    private lazy var stockValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Double(2497.20).currencyRepresentation
        label.font = UIFontMetrics(forTextStyle: .caption2).scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .regular))

        return label
    }()

    private lazy var containerView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [prefixLabel, stockValueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = UXSpacing.halfX
        stackView.alignment = .center
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
        ])
    }
    
    public func configView(with prefixLabelText: String, numericValue: Double, shouldHighlightNumericValue: Bool = false) {
        self.prefixLabel.text = "\(prefixLabelText):"
        self.stockValueLabel.text = "\(numericValue.currencyRepresentation)"
        if shouldHighlightNumericValue {
            self.stockValueLabel.textColor = numericValue > 0 ? UIColor.systemGreen : UIColor.red
        }
    }
}
