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
        

        else {
            Common.events.listOfEvents.append(Event(id: 4, idOrganizer: Common.myProfile.id, idMembers: [Common.myProfile.id], name: name, description: description, place: place, date: date))
            
            let successfullyСreatedController = UIAlertController(title: "Успех", message: "Ваше мероприятие успешно создано", preferredStyle: .alert)
            successfullyСreatedController.addAction(UIAlertAction(title: "Ок", style: .default))
            viewController?.present(successfullyСreatedController, animated: true)

            let listNavigationControllers  = viewController?.tabBarController!.viewControllers![0] as! UINavigationController
            let listNavigationController = listNavigationControllers.viewControllers[0] as! EventListController
            listNavigationController.updateList()
                                    
            let organizingListNavigationControllers  = viewController?.tabBarController!.viewControllers![1] as! UINavigationController
            let organizingListNavigationController = organizingListNavigationControllers.viewControllers[0] as! EventListController
            organizingListNavigationController.updateList()
            
            let participatingListNavigationControllers  = viewController?.tabBarController!.viewControllers![2] as! UINavigationController
            let participatingListNavigationController = participatingListNavigationControllers.viewControllers[0] as! EventListController
            participatingListNavigationController.updateList()
            
            let addEventNavigationControllers  = viewController?.tabBarController!.viewControllers![3] as! UINavigationController
            let addEventNavigationController = addEventNavigationControllers.viewControllers[0] as! AddEventViewController
            addEventNavigationController.cleanScreen()
            
        }
    }
}
