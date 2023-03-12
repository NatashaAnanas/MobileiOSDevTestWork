//
//  HeaderCell.swift
//  TestWork
//
//  Created by Анастасия Козлова on 08.03.2023.
//

import UIKit

/// Хедер таблицы со сделками
final class HeaderCell: UITableViewHeaderFooterView {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let instrumentText = "Instrument"
        static let priceText = "Price"
        static let amountText = "Amount"
        static let sideText = "Side"
        static let fatalErrorText = "init(coder:) has not been implemented"
    }
    
    // MARK: - Private Visual Components
    
    private let instrumentNameTitlLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.contentMode = .center
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.contentMode = .center
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.contentMode = .center
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sideTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.contentMode = .center
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    // MARK: - Public Methods
    
    func configure() {
        instrumentNameTitlLabel.text = Constants.instrumentText
        priceTitleLabel.text = Constants.priceText
        amountTitleLabel.text = Constants.amountText
        sideTitleLabel.text = Constants.sideText
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        addSubview(instrumentNameTitlLabel)
        addSubview(priceTitleLabel)
        addSubview(amountTitleLabel)
        addSubview(sideTitleLabel)
    }
    
    private func setupConstraints() {
        setupInstrumentNameLabel()
        setupPriceLabel()
        setupAmountLabel()
        setupSideLabel()
    }
    
    private func setupInstrumentNameLabel() {
        NSLayoutConstraint.activate([
            instrumentNameTitlLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            instrumentNameTitlLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            instrumentNameTitlLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    private func setupPriceLabel() {
        NSLayoutConstraint.activate([
            priceTitleLabel.leadingAnchor.constraint(equalTo: instrumentNameTitlLabel.trailingAnchor, constant: 20),
            priceTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            priceTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    private func setupAmountLabel() {
        NSLayoutConstraint.activate([
            amountTitleLabel.leadingAnchor.constraint(equalTo: priceTitleLabel.trailingAnchor, constant: 20),
            amountTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            amountTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    private func setupSideLabel() {
        NSLayoutConstraint.activate([
            sideTitleLabel.leadingAnchor.constraint(equalTo: amountTitleLabel.trailingAnchor, constant: 20),
            sideTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            sideTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            sideTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
