import UIKit

final class OrganizerScreenRouter {
    
    
}

extension OrganizerScreenRouter: OrganizerScreenRouterInput {
    static var personID = -1
    
    func sendPersonToOrganizerScreen(id: Int) {
        OrganizerScreenRouter.personID = id
    }
    
}
