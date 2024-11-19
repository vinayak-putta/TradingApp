//
//  DividerView.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 19/11/24.
//

import UIKit

class DividerView: UIView {
    private lazy var dividerView: UIView = {
        let divder = UIView()
        divder.translatesAutoresizingMaskIntoConstraints = false
        divder.backgroundColor = color
        return divder
    }()
    
    private let height: CGFloat
    private let horizontalSpacing: CGFloat
    private let color: UIColor

    init(height: CGFloat, horizontalSpacing: CGFloat, color: UIColor = .lightGray) {
        self.height = height
        self.horizontalSpacing = horizontalSpacing
        self.color = color
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(dividerView)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height),
            dividerView.topAnchor.constraint(equalTo: self.topAnchor),
            dividerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalSpacing),
            dividerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalSpacing)
        ])
    }
}
