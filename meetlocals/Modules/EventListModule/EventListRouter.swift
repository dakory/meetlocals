//
//  EventListRouter.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class EventListRouter {
    var viewController: UIViewController?
}

extension EventListRouter: EventListRouterInput {
    func showAddEvent() {
        let context = AddEventContext(moduleOutput: nil)
        let container = AddEventContainer.assemble(with: context)
        let navVC = UINavigationController(rootViewController: container.viewController)
        self.viewController?.present(navVC, animated: true)
    }
    
    func showEvent() {
        let alertController = UIAlertController(title: "Показать событие", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Закрыть", style: .default))
        viewController?.present(alertController, animated: true)
    }
}


    
    

