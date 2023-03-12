//
//  TransactionPresenter.swift
//  TestWork
//
//  Created by Анастасия Козлова on 12.03.2023.
//

import Foundation

/// Презентер экрана со сделками
final class TransactionPresenter: TransactionPresenterProtocol {
    
    // MARK: - Public Properties
    
    weak var view: TransactionViewProtocol?
    var server: Server?
    var model: [Deal] = []
    
    // MARK: - Private Properties
    
    private var sortField: FieldSorted = .date {
        didSet {
            self.view?.reloadTableView()
        }
    }
    
    // MARK: - Initializers
    
    init(server: Server?) {
        self.server = server
    }
    
    // MARK: - Public Methods
    
    func getServerData() {
        server?.subscribeToDeals { [weak self] deals in
            self?.model.append(contentsOf: deals)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sortedTransaction(field: .date)
        }
    }
    
    func directionAction(tag: Int) {
        switch tag {
        case 0:
            sortedTransaction(field: sortField, order: .ascending)
        case 1:
            sortedTransaction(field: sortField, order: .descending)
        default:
            break
        }
    }
    
    func sortedTransaction(field : FieldSorted, order: Order = .descending) {
        DispatchQueue.main.async {
            switch order {
            case .ascending:
                switch field {
                case .date:
                    self.model.sort { $0.dateModifier < $1.dateModifier }
                    self.sortField = .date
                case .amount:
                    self.model.sort { $0.amount < $1.amount }
                    self.sortField = .amount
                case .side:
                    self.model.sort { $0.side.hashValue < $1.side.hashValue }
                    self.sortField = .side
                case .price:
                    self.model.sort { $0.price < $1.price }
                    self.sortField = .price
                case .instrument:
                    self.model.sort { $0.instrumentName < $1.instrumentName }
                    self.sortField = .instrument
                }
            case .descending:
                switch field {
                case .date:
                    self.model.sort { $0.dateModifier > $1.dateModifier }
                    self.sortField = .date
                case .amount:
                    self.model.sort { $0.amount > $1.amount }
                    self.sortField = .amount
                case .side:
                    self.model.sort { $0.side.hashValue > $1.side.hashValue }
                    self.sortField = .side
                case .price:
                    self.model.sort { $0.price > $1.price }
                    self.sortField = .price
                case .instrument:
                    self.model.sort { $0.instrumentName > $1.instrumentName }
                    self.sortField = .instrument
                }
            }
        }
    }
}
