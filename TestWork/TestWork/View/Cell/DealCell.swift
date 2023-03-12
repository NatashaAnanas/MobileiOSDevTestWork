//
//  TableViewCell.swift
//  TestWork
//
//  Created by Анастасия Козлова on 07.03.2023.
//

import UIKit

/// Ячейка с информацией о сделке
final class DealCell: UITableViewCell {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let sellText = "sell"
        static let buyText = "buy"
        static let formatTwo = "%.2f"
        static let formatZero = "%.0f"
        static let dateFormat = "hh:mm:ss dd.MM.yyyy"
    }
    
    // MARK: - Private Visual Components
    
    private let instrumentNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sideLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Public Methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
        setupConstraints()
    }
    
    func configure(model: Deal) {
        instrumentNameLabel.text = model.instrumentName
        priceLabel.text = String(format: Constants.formatTwo, model.price)
        amountLabel.text =  String(format: Constants.formatZero, model.amount)
        createSide(side: model.side)
        dateLabel.text = getFormattedDate(date: model.dateModifier)
    }
    
    // MARK: - Private Methods
    
    private func getFormattedDate(date: Date) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = Constants.dateFormat
        return dateformat.string(from: date)
    }
    
    private func setupUI() {
        addSubview(instrumentNameLabel)
        addSubview(priceLabel)
        addSubview(amountLabel)
        addSubview(sideLabel)
        addSubview(dateLabel)
    }
    
    private func createSide(side: Deal.Side) {
        switch side {
        case .sell:
            sideLabel.text = Constants.sellText
            sideLabel.textColor = .red
            priceLabel.textColor = .red
        case .buy:
            sideLabel.text = Constants.buyText
            sideLabel.textColor = .green
            priceLabel.textColor = .green
        }
    }
    
    private func setupConstraints() {
        setupInstrumentNameLabel()
        setupPriceLabel()
        setupAmountLabel()
        setupSideLabel()
        setupDateLabel()
    }
    
    private func setupDateLabel() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    private func setupInstrumentNameLabel() {
        NSLayoutConstraint.activate([
            instrumentNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            instrumentNameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            instrumentNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    private func setupPriceLabel() {
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: instrumentNameLabel.trailingAnchor, constant: 20),
            priceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    private func setupAmountLabel() {
        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20),
            amountLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    private func setupSideLabel() {
        NSLayoutConstraint.activate([
            sideLabel.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 20),
            sideLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            sideLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            sideLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
