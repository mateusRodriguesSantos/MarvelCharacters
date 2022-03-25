//
//  DetailsCoordinator.swift
//  MarvelCharactersDetails
//
//  Created by Mateus Rodrigues on 24/03/22.
//

import UIKit

protocol DetailsCoordinatorType {}
enum DetailsCoordinatorDestinys: Destinys, DetailsCoordinatorType {
    case back
}

class DetailsCoordinator: SharedCoordinatorProtocol, DetailsCoordinatorType {
    
    internal var id: String
    internal var childCoordinators: [CoordinatorProtocol]
    internal var navigationController: UINavigationController?

    init() {
        childCoordinators = []
        id = UUID().uuidString
    }
    func start(navigation: UINavigationController) {
        let viewController = DetailsViewController()
        self.navigationController = navigation
        navigation.pushViewController(viewController, animated: true)
    }
    
    func callEvent(event: Destinys) {
        if let eventNav = event as? DetailsCoordinatorDestinys {
            switch eventNav {
            case .back:
                PeformNavigation.navigate(event: AppCoordinatorDestinys.removeItem(coordinator: self))
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
