//
//  LogInCoordinator.swift
//  Movies
//
//  Created by Olga Sabadina on 05.01.2024.
//

import UIKit


class LoginCoordinator: BaseCoordinator {
    
    weak var appCoordinator: AppCoordinator?

    override func start() {
        showLoginViewController()
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func showLoginViewController() {
        let loginVC: LoginViewController = .init()
        
        loginVC.didSendEventClosure = { [weak self]  in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self?.appCoordinator?.isAuthorized = .loggedIn
            }
        }
        
        navigationController.pushViewController(loginVC, animated: true)
    }
}
