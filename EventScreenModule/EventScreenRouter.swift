
import UIKit

final class EventScreenRouter {
}

extension EventScreenRouter: EventScreenRouterInput {
    
    func organizerScreen(vc: EventScreenViewController, organizer: Person){
     //здесь осуществляем переход на "Профиль организатора"
        let contexOrganizerScreen = OrganizerScreenContext(moduleOutput: nil)
        let containerOrganizerScreen = OrganizerScreenContainer.assemble(with: contexOrganizerScreen)
         
        containerOrganizerScreen.router.sendPersonToOrganizerScreen(per: organizer)
        vc.navigationController?.pushViewController(containerOrganizerScreen.viewController, animated: true) //подходит для перехода стэком с возможностью вернуться назад

  //      vc.view.window?.rootViewController = container2.viewController //подходит для полного перехода, с удалением первого экрана
    }
}
