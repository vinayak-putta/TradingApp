//
//  PortfolioSummarySubTypeTwoLabelView.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import UIKit

class PortfolioSummarySubTypeTwoLabelView: UIView {
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
    }()

    private lazy var numericTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "697.06 (2.44%)"
        
        return label
    }()
    
    private lazy var containerView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [textLabel, numericTextLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: UXSpacing.twoX),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UXSpacing.twoX),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UXSpacing.twoX),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UXSpacing.twoX),
        ])
    }
    
    public func configView(with labelText: String, numericValue: Double, shouldHighlightNumericValue: Bool = false) {
        self.textLabel.text = "\(labelText)"
        self.numericTextLabel.text = "\(numericValue.currencyRepresentation)"
        if shouldHighlightNumericValue {
            self.numericTextLabel.textColor = numericValue > 0 ? UIColor.green : UIColor.red
        }
    }
}
