//
//  PortfolioSummarySubTypeOneLabelView.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import UIKit

protocol PortfolioSummaryViewDelegate: AnyObject {
    func expandSummaryView(_ shouldExpandView: Bool)
}

enum ChevronDirection {
    case down
    case up
}


class PortfolioSummarySubTypeOneLabelView: UIView {
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
//        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var numericTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "697.06 (2.44%)"
        
        return label
    }()
    
    private lazy var chevronImage: UIImageView = {
        let chevron = UIImageView()
        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.contentMode = .scaleAspectFit
        let configuration = UIImage.SymbolConfiguration(weight: .black)
        chevron.image = UIImage(systemName: "chevron.up", withConfiguration: configuration)
        chevron.tintColor = .systemGray
        chevron.setContentHuggingPriority(.defaultHigh, for: .vertical)
        chevron.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return chevron
    }()
    
    private lazy var subContainerView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [textLabel, chevronImage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = UXSpacing.oneX
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var containerView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [subContainerView, numericTextLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    private var isExpanded: Bool = false
    private weak var delegate: PortfolioSummaryViewDelegate?

    init(delegate: PortfolioSummaryViewDelegate) {
        super.init(frame: .zero)
        setupViews()
        setTapHander()
        self.delegate = delegate
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
            
            chevronImage.heightAnchor.constraint(equalToConstant: UXSpacing.twoX),
            chevronImage.widthAnchor.constraint(equalTo: chevronImage.heightAnchor),
        ])
    }
    
    private func setTapHander() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapChevronImage))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapChevronImage() {
        isExpanded.toggle()
        if isExpanded {
            setChevronImageDirection(chevronDirection: .down)
            delegate?.expandSummaryView(true)
        } else {
            setChevronImageDirection(chevronDirection: .up)
            delegate?.expandSummaryView(false)
        }
    }
    
    private func setChevronImageDirection(chevronDirection: ChevronDirection) {
        let configuration = UIImage.SymbolConfiguration(weight: .black)
        if chevronDirection == .down {
            chevronImage.image = UIImage(systemName: "chevron.down", withConfiguration: configuration)
        } else {
            chevronImage.image = UIImage(systemName: "chevron.up", withConfiguration: configuration)
        }
    }
    
    public func configView(with labelText: String, numericValue: Double, numericPercent: Double, shouldHighlightNumericValue: Bool = false) {
        self.textLabel.text = labelText
        self.numericTextLabel.text = "\(numericValue.currencyRepresentation) (\(numericPercent.rounded(toPlaces: 2))%)"
        if shouldHighlightNumericValue {
            self.numericTextLabel.textColor = numericValue > 0 ? UIColor.systemGreen : UIColor.red
        }
    }
}
