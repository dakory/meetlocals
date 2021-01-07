
import UIKit

final class EventScreenRouter {
        var viewController: UIViewController?
}

extension EventScreenRouter: EventScreenRouterInput {

    func deleteEvent(eventId: Int) {
        let alertView = UIAlertController.init(title: "Вы точно хотите удалить событие?", message: "Его невозможно будет восстановить", preferredStyle: .alert)

        let YesAction = UIAlertAction(title: "Да", style: .default) { action in
            
            let client = APIClient()
            client.deleteDataTask("events/\(eventId)") { (result: Result<Any, Error>) in
                do {
                    let response = try result.get()
                    print(response)
                    client.getDataTask("events") { (result: Result<EventsResponse, Error>) in
                        do {
                            let eventsResponse = try result.get()
                            print(eventsResponse.events)
                            
                            Common.events.listOfEvents = eventsResponse.events

                            let listNavigationControllers  = self.viewController?.tabBarController!.viewControllers![0] as! UINavigationController
                            let listNavigationController = listNavigationControllers.viewControllers[0] as! EventListController
                            listNavigationController.updateList()
                                                    
                            let organizingListNavigationControllers  = self.viewController?.tabBarController!.viewControllers![1] as! UINavigationController
                            let organizingListNavigationController = organizingListNavigationControllers.viewControllers[0] as! EventListController
                            organizingListNavigationController.updateList()
                            
                            let participatingListNavigationControllers  = self.viewController?.tabBarController!.viewControllers![2] as! UINavigationController
                            let participatingListNavigationController = participatingListNavigationControllers.viewControllers[0] as! EventListController
                            participatingListNavigationController.updateList()
                            
                            self.viewController?.navigationController?.popViewController(animated: true)
                            self.viewController?.dismiss(animated: true)
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
            print("Мероприятие удалено")
        }
        let NoAction = UIAlertAction(title: "Нет", style: .default) { action in
            print("Мероприятие не удалено")
            self.viewController?.navigationController?.navigationBar.isUserInteractionEnabled = true
        }

        alertView.addAction(YesAction)
        alertView.addAction(NoAction)
        self.viewController?.present(alertView, animated: true)
    }
    
    func organizerScreen(vc: EventScreenViewController, organizerID: Int){ //здесь осуществляем переход на "Профиль организатора"
        let contexOrganizerScreen = OrganizerScreenContext(moduleOutput: nil, personID: organizerID)
        let containerOrganizerScreen = OrganizerScreenContainer.assemble(with: contexOrganizerScreen)
        
        let transition = CATransition()
        transition.duration = 0.6
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        vc.navigationController?.view.layer.add(transition, forKey: kCATransition)
        vc.navigationController?.pushViewController(containerOrganizerScreen.viewController, animated: true)
    }
    
    func updateScreens (vc: EventScreenViewController){
        let participatingListNavigationControllers  = vc.tabBarController!.viewControllers![2] as! UINavigationController
        let participatingListNavigationController = participatingListNavigationControllers.viewControllers[0] as! EventListController
        participatingListNavigationController.updateList()
    }
    
    func goToVk(id: Int) {
        let vkID = id
        let appURL = NSURL(string: "vk://vk.com/id\(vkID)")!
        let safariURL = URL(string: "https://vk.com/id\(vkID)")!

        if UIApplication.shared.canOpenURL(appURL as URL){
            UIApplication.shared.open(appURL as URL)
        } else {
            UIApplication.shared.open(safariURL)
        }
    }
}
