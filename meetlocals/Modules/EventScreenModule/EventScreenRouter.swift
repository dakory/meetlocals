
import UIKit

final class EventScreenRouter {
}

extension EventScreenRouter: EventScreenRouterInput {
    
    func organizerScreen(vc: EventScreenViewController, organizerID: Int){ //здесь осуществляем переход на "Профиль организатора"
        let contexOrganizerScreen = OrganizerScreenContext(moduleOutput: nil, personID: organizerID)
        let containerOrganizerScreen = OrganizerScreenContainer.assemble(with: contexOrganizerScreen)
        vc.navigationController?.pushViewController(containerOrganizerScreen.viewController, animated: true)
    }
}
