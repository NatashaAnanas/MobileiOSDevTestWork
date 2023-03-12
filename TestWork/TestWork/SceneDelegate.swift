//
//  SceneDelegate.swift
//  TestWork
//
//  Created by Анастасия Козлова on 07.03.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let server = Server()
        let presenter = TransactionPresenter(server: server)
        let view = TransactionViewController(presenter: presenter)
        presenter.view = view
        
//        let presenter = TransactionPresenter(server: Server())
//        presenter.view = TransactionViewController(presenter: presenter)
        
        window.rootViewController = UINavigationController(rootViewController: view)
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

