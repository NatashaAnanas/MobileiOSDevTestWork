//
//  TransactionAssembly.swift
//  TestWork
//
//  Created by Анастасия Козлова on 12.03.2023.
//

import UIKit

/// Сборщик экрана со сделками 
enum TransactionAssembly {
    static func configured() -> UIViewController {
        let server = Server()
        let presenter = TransactionPresenter(server: server)
        let viewController = TransactionViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
