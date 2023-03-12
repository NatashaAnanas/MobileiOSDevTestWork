//
//  Helper.swift
//  TestWork
//
//  Created by Анастасия Козлова on 12.03.2023.
//

import Foundation

/// Параметры сделки
enum FieldSorted {
   case date
   case instrument
   case price
   case amount
   case side
}

/// Направление сортировки
enum Order {
   case ascending
   case descending
}
