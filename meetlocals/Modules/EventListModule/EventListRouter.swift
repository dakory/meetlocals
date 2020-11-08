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
        // TODO открыть AddEventModule
        let alertController = UIAlertController(title: "Добавить событие", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "Добавить", style: .default)
        )
        

    viewController?.present(alertController, animated: true)
    }
    
    func showEvent() {
        let alertController = UIAlertController(title: "Показать событие", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Закрыть", style: .default))
        viewController?.present(alertController, animated: true)

        // TODO открыть EventModule
    }
}


    
    
