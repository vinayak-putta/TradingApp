//
//  ViewController.swift
//  TradingApp
//
//  Created by Vinayak Ganesh Putta on 16/11/24.
//

import UIKit

class StocksHoldingViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(StockHoldinglTableViewCell.self, forCellReuseIdentifier: StockHoldinglTableViewCell.reuseIdentifier)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        return tableview
    }()
    
    private lazy var portfolioSummaryView: PortfolioSummaryView = {
        let summaryView = PortfolioSummaryView()
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        summaryView.isHidden = true
        return summaryView
    }()
    
    private let activityIndicator = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    private lazy var tableViewDataSource: [Stock] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                let portfolioSummaryViewData = self.dataTransformer.makeProfileSummaryViewData(from: self.tableViewDataSource)
                self.portfolioSummaryView.configureView(with: portfolioSummaryViewData)
                self.portfolioSummaryView.isHidden = false
            }
        }
    }
    private lazy var dataTransformer = StockHoldingDataTransformer()
    private lazy var viewModel = StockHoldingsViewModel(repository: HoldingsRepository(httpClient: URLSession(configuration: .default, delegate: InsecureSessionDelegate(), delegateQueue: nil)))

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Holding"
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(tableView)
        view.addSubview(portfolioSummaryView)
        view.addSubview(activityIndicator)
        setupConstraints()
        activityIndicator.startAnimating()

        viewModel.fetchALLHoldings { [weak self] data in
            switch data {
            case .success(let data):
                self?.tableViewDataSource = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            portfolioSummaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            portfolioSummaryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            portfolioSummaryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

extension StocksHoldingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: StockHoldinglTableViewCell.reuseIdentifier, for: indexPath) as? StockHoldinglTableViewCell else {
            fatalError("Failed dequeue StockHoldinglTableViewCell")
        }
        
        let data = tableViewDataSource[indexPath.item]
        let viewData = dataTransformer.makeStockHoldingCellViewData(from: data)
        tableViewCell.configView(with: viewData)
        
        return tableViewCell
    }
}


class InsecureSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Accept all certificates
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}



