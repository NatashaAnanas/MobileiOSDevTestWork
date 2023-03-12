//
//  TransactionPresenterProtocol.swift
//  TestWork
//
//  Created by Анастасия Козлова on 12.03.2023.
//

import Foundation

enum FieldSorted {
   case date
   case instrument
   case price
   case amount
   case side
}

enum Order {
   case ascending
   case descending
}

protocol TransactionPresenterProtocol {
    var server: Server? { get set }
    var model: [Deal] { get set }
    func getServerData()
    func directionAction(tag: Int)
    func sortedTransaction(field : FieldSorted, order: Order)
}
