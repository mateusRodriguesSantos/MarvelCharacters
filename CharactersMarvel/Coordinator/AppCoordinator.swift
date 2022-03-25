//
//  AppCoordinator.swift
//  MarvelCharactersDetails
//
//  Created by Mateus Rodrigues on 24/03/22.
//

import UIKit

struct PeformNavigation {
    static func navigate(event: Destinys) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        guard let listCoordinators = sceneDelegate.appCoordinator?.childCoordinators else { return }
        sceneDelegate.appCoordinator?.callEvent(event: event)
        if !listCoordinators.isEmpty {
            listCoordinators.forEach({ coordinator in
                coordinator.callEvent(event: event)
            })
        }
    }
}

protocol Events {
    func callEvent(event: Destinys)
}

protocol CoordinatorProtocol: Events {
    var id: String { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController? { get set }
    func start()
}

protocol SharedCoordinatorProtocol: CoordinatorProtocol {
    func start(navigation: UINavigationController)
}

extension SharedCoordinatorProtocol {
    func start() {}
}

protocol Destinys {}

protocol AppCoordinatorType {}
enum AppCoordinatorDestinys: Destinys, AppCoordinatorType {

    case list
    case details
    case removeItem(coordinator: CoordinatorProtocol)
}

class AppCoordinator: CoordinatorProtocol, AppCoordinatorType {
    
    internal var id: String
    internal var childCoordinators: [CoordinatorProtocol]
    private let window: UIWindow
    internal var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
        childCoordinators = []
        id = UUID().uuidString
    }
    
    func start() {
        childCoordinators = []
        let viewController = CharactersListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func callEvent(event: Destinys) {
        if let eventNav = event as? AppCoordinatorDestinys {
            switch eventNav {
            case .list:
                navigateToList()
            case .details:
                navigateToDetails()
            case .removeItem(let coordinator):
                childCoordinators.enumerated().forEach { index, element in
                    if element.id == coordinator.id {
                        childCoordinators.remove(at: index)
                    }
                }
            }
        }
    }
    
}

extension AppCoordinator {
    
    func navigateToList() {
        let viewController = CharactersListViewController()
        navigationController?.present(viewController, animated: true)
    }
    
    func navigateToDetails() {
        guard let navigationController = navigationController else { return }
        let coordinator = DetailsCoordinator()
        childCoordinators.append(coordinator)
        coordinator.start(navigation: navigationController)
    }
    
}
