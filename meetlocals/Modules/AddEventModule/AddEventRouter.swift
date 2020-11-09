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
        if name.isEmpty || description.isEmpty || place.isEmpty || name == "Опишите кратко" || description ==  "Опишите кратко" ||
        place == "Место" || name == "Введите что-нибудь" || description == "Введите что-нибудь" || place == "Введите что-нибудь"{
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
            Common.events.listOfEvents.append(Event(id: 3, idOrganizer: 1, idMembers: [], name: name, description: description, place: place, date: date))
            let contex = EventListContext(moduleOutput: nil)
            let container = EventListContainer.assemble(with: contex)
            let navigationController = UINavigationController(rootViewController: container.viewController)
            self.viewController?.view.window?.rootViewController = navigationController
        }
    }
}
