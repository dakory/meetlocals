import Foundation
import UIKit


final class OrganizerScreenPresenter {
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
    func setOrganizerData(person: Profile){
        (self.view as! OrganizerScreenViewController).nameOfPerson.text = "\(person.name) \(person.surname)"
        (self.view as! OrganizerScreenViewController).imageOfPerson.image =  UIImage(named: person.avatarUrl!)

    }
}

extension OrganizerScreenPresenter: OrganizerScreenViewOutput {
    func getData(){
        let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id ==  OrganizerScreenRouter.personID})
        let organizer = Common.profiles.profiles[indexPerson!]
        setOrganizerData(person: organizer)
    }
}

extension OrganizerScreenPresenter: OrganizerScreenInteractorOutput {
}
