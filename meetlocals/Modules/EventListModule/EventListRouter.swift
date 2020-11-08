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
    
    func goToEventScreen(vc: EventListController, meetingID: Int){ //здесь осуществляем переход на "Профиль организатора"
        let contexEventScreen = EventScreenContext(moduleOutput: nil)
        let containerEventScreen = EventScreenContainer.assemble(with: contexEventScreen)        
        containerEventScreen.router.sendToEventsScreen(id: meetingID)
        vc.navigationController?.pushViewController(containerEventScreen.viewController, animated: true) //подходит для перехода стэком с возможностью вернуться назад
    }
    
}



    
    

