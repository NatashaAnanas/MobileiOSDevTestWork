//
//  TransactionPresenterProtocol.swift
//  TestWork
//
//  Created by Анастасия Козлова on 12.03.2023.
//

import Foundation

/// Протокол презентера экрана со сделками
protocol TransactionPresenterProtocol {
    var server: Server? { get set }
    var model: [Deal] { get set }
    func getServerData()
    func directionAction(tag: Int)
    func sortedTransaction(field : FieldSorted, order: Order)
}
