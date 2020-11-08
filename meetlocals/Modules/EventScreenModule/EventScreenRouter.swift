
import UIKit

final class EventScreenRouter {
}

extension EventScreenRouter: EventScreenRouterInput {
    
    static var eventID = 0
    
    func sendToEventsScreen(id: Int) {
        EventScreenRouter.eventID = id
    }
    
    func organizerScreen(vc: EventScreenViewController, organizerID: Int){ //здесь осуществляем переход на "Профиль организатора"
        let contexOrganizerScreen = OrganizerScreenContext(moduleOutput: nil)
        let containerOrganizerScreen = OrganizerScreenContainer.assemble(with: contexOrganizerScreen)
        containerOrganizerScreen.router.sendPersonToOrganizerScreen(id: organizerID)
        vc.navigationController?.pushViewController(containerOrganizerScreen.viewController, animated: true) //подходит для перехода стэком с возможностью вернуться назад

  //      vc.view.window?.rootViewController = container2.viewController //подходит для полного перехода, с удалением первого экрана
    }
}
