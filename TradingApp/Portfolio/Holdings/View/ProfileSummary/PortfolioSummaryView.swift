//
//  PortfolioSummaryView.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import UIKit

class PortfolioSummaryView: UIView, PortfolioSummaryViewDelegate {
    
    private lazy var expandableSectionView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [currentValueView, totalInvestmentView, todaysTotalProfitAndLossView, dividerView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isHidden = true
        return stackView
    }()
        
    private lazy var containerView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [expandableSectionView, totalProfitAndLossView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
//        stackView.spacing = 10
        stackView.backgroundColor = UIColor.systemGray6
//        stackView.clipsToBounds = true
        return stackView
    }()
    
    private lazy var totalProfitAndLossView: PortfolioSummarySubTypeOneLabelView = {
        let view = PortfolioSummarySubTypeOneLabelView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currentValueView: PortfolioSummarySubTypeTwoLabelView = {
        let view = PortfolioSummarySubTypeTwoLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var totalInvestmentView: PortfolioSummarySubTypeTwoLabelView = {
        let view = PortfolioSummarySubTypeTwoLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dividerView: DividerView = {
        let view = DividerView(height: 1, horizontalSpacing: UXSpacing.twoX)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var todaysTotalProfitAndLossView: PortfolioSummarySubTypeTwoLabelView = {
        let view = PortfolioSummarySubTypeTwoLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

        containerView.layer.cornerRadius = UXSpacing.twoX
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func expandSummaryView(_ shouldExpandView: Bool) {
        UIView.animate(withDuration: 0.1) {
            if shouldExpandView {
                self.expandableSectionView.isHidden = false
            } else {
                self.expandableSectionView.isHidden = true
            }
        }
    }
    
    public func configureView(with viewData: PortfolioSummaryViewData) {
        currentValueView.configView(with: String(localized: "currentValueKey"), numericValue: viewData.currentValue)
        totalInvestmentView.configView(with: String(localized: "totalInvestmentKey"), numericValue: viewData.totalInvestment)
        todaysTotalProfitAndLossView.configView(with: String(localized: "todaysProfitLossKey"), numericValue: viewData.todaysProfitAndLoss, shouldHighlightNumericValue: true)
        totalProfitAndLossView.configView(with: String(localized: "profitAndLossKey"), numericValue: viewData.totalProfitAndLoss, numericPercent: viewData.profitAndLossPercent, shouldHighlightNumericValue: true)
    }
    
}
