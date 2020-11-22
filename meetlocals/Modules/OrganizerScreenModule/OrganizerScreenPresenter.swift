import Foundation
import UIKit


final class OrganizerScreenPresenter {
    var personId: Int?
    
	weak var view: OrganizerScreenViewInput?
    weak var moduleOutput: OrganizerScreenModuleOutput?
    
	private let router: OrganizerScreenRouterInput
	private let interactor: OrganizerScreenInteractorInput
    
    init(router: OrganizerScreenRouterInput, interactor: OrganizerScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension OrganizerScreenPresenter: OrganizerScreenModuleInput {
}

extension OrganizerScreenPresenter: OrganizerScreenViewOutput {
    func getData(){
        let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id ==  personId})
        let organizer = Common.profiles.profiles[indexPerson!]
        self.view!.setOrganizerData(person: organizer)
    }
}

extension OrganizerScreenPresenter: OrganizerScreenInteractorOutput {
}
