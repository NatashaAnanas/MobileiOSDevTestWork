//
//  Deal.swift
//  TestWork
//
//  Created by Анастасия Козлова on 11.03.2023.
//

import Foundation

/// Информация о сделке
struct Deal {
    /// Идентификатор сделки
    let id: Int64
    /// Дата изменения сделки
    let dateModifier: Date
    /// Имя инструмента
    let instrumentName: String
    /// Цена сделки
    let price: Double
    /// Объем сделки
    let amount: Double
    /// Cторона сделки
    let side: Side
    
  enum Side: CaseIterable {
    case sell, buy
  }
}
