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
            
            let client = APIClient()

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let dateString = formatter.string(from: date)
            
            let newEvent: [String: Any] = [
                "name": name,
                "description": description,
                "location": place,
                "date": dateString,
                "organizer_id": Common.myProfile.id
            ]
            
            client.postDataTask("events", data: newEvent) { (result: Result<EventResponse, Error>) in
                do {
                    let eventResponse = try result.get()
                    print(eventResponse.event)
                    client.getDataTask("events") { (result: Result<EventsResponse, Error>) in
                        do {
                            let eventsResponse = try result.get()
                            print(eventsResponse.events)
                            
                            Common.events.listOfEvents = eventsResponse.events
                            
                            let successfullyСreatedController = UIAlertController(title: "Успех", message: "Ваше мероприятие успешно создано", preferredStyle: .alert)
                            successfullyСreatedController.addAction(UIAlertAction(title: "Ок", style: .default))
                            self.viewController?.present(successfullyСreatedController, animated: true)

                            let listNavigationControllers  = self.viewController?.tabBarController!.viewControllers![0] as! UINavigationController
                            let listNavigationController = listNavigationControllers.viewControllers[0] as! EventListController
                            listNavigationController.updateList()
                                                    
                            let organizingListNavigationControllers  = self.viewController?.tabBarController!.viewControllers![1] as! UINavigationController
                            let organizingListNavigationController = organizingListNavigationControllers.viewControllers[0] as! EventListController
                            organizingListNavigationController.updateList()
                            
                            let participatingListNavigationControllers  = self.viewController?.tabBarController!.viewControllers![2] as! UINavigationController
                            let participatingListNavigationController = participatingListNavigationControllers.viewControllers[0] as! EventListController
                            participatingListNavigationController.updateList()
                            
                            let addEventNavigationControllers  = self.viewController?.tabBarController!.viewControllers![3] as! UINavigationController
                            let addEventNavigationController = addEventNavigationControllers.viewControllers[0] as! AddEventViewController

                            addEventNavigationController.cleanScreen()
                        }
                        catch {
                            print(error)
                        }
                    }
                }
                catch {
                    print(error)
                }
            }

        }
    }
}
