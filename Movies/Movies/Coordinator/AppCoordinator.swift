//
//  AppCoordinator.swift
//  Movies
//
//  Created by Olga Sabadina on 05.01.2024.
//

import UIKit
import Combine

enum SessionState {
    case loggedIn
    case loggedOut
    case flashScreen
}

class AppCoordinator: BaseCoordinator {
    
    @Published var isAuthorized = SessionState.flashScreen
    
    private var cancellable = Set<AnyCancellable>()
    
    required init(_ navigationController: UINavigationController, type: CoordinatorType) {
        super.init(navigationController, type: type)
        start()
    }
    
    override func start() {
        coordinatorDidFinish(childCoordinator: .app)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isAuthorized = .loggedOut
            self.sinkToSessionState()
        }
    }
    
    func sinkToSessionState() {
       $isAuthorized
            .sink { [weak self] state in
            switch state {
            case .loggedIn:
                self?.coordinatorDidFinish(childCoordinator: .login)
            case .loggedOut:
                self?.coordinatorDidFinish(childCoordinator: .tab)
            case .flashScreen:
                self?.coordinatorDidFinish(childCoordinator: .app)
            }
        }
        .store(in: &cancellable)
    }
        
    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator.init(navigationController, type: .login)
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }
    
    func showMainFlow() {
       let tabCoordinator = TabCoordinator.init(navigationController, type: .tab)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: CoordinatorType) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator })

        switch childCoordinator {
        case .tab:
            navigationController.viewControllers.removeAll()

            showLoginFlow()
        case .login:
            navigationController.viewControllers.removeAll()

            showMainFlow()
        case .app:
            let flashVC = SplashViewController()
            navigationController.viewControllers = [flashVC]
        }
    }
}
