//
//  AddEventRouter.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class AddEventRouter {
    var viewController: UIViewController?
}

extension AddEventRouter: AddEventRouterInput {
    func addEvent(name: String, description: String, date: Date, place: String) {
        if name.isEmpty || description.isEmpty || place.isEmpty {
            let alertController = UIAlertController(title: "Ошибка", message: "Пожалуйста, заполните все поля", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ок", style: .default)
            )
            viewController?.present(alertController, animated: true)
            return
        }
        else if (date as NSDate).timeIntervalSinceNow.sign == .minus {
                let alertController = UIAlertController(title: "Ошибка", message: "Вы не можете создавать событие в прошлом", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ок", style: .default)
                )
                viewController?.present(alertController, animated: true)
                return
        }
        
        
        
        // TODO: переносить данные в бд, обновлять экран событий
        else {
            Common.events.listOfEvents.append(Event(id: 3, idOrganizer: Common.myProfile.id, idMembers: [], name: name, description: description, place: place, date: date))
            
            let successfullyСreatedController = UIAlertController(title: "Успех", message: "Ваше мероприятие успешно создано", preferredStyle: .alert)
            successfullyСreatedController.addAction(UIAlertAction(title: "Ок", style: .default))
            viewController?.present(successfullyСreatedController, animated: true)

            let listNavigationController  = viewController?.tabBarController!.viewControllers![0] as! UINavigationController
            let listNavigationControllers = listNavigationController.viewControllers[0] as! EventListController
            listNavigationControllers.updateList()
            
            let addEventNavigationController  = viewController?.tabBarController!.viewControllers![2] as! UINavigationController
            let addEventNavigationControllers = addEventNavigationController.viewControllers[0] as! AddEventViewController
            addEventNavigationControllers.cleanScreen()
            
        }
    }
}
