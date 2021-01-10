
import UIKit

final class EventScreenRouter {
        var viewController: UIViewController?
}

extension EventScreenRouter: EventScreenRouterInput {
    func deleteEvent() {
        self.viewController?.navigationController?.popViewController(animated: true)
        self.viewController?.dismiss(animated: true)
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
