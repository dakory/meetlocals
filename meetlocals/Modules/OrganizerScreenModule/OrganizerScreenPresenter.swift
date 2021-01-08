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
    func didTapButtonOpenVK() {
        let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id ==  personId})
        let organizer = Common.profiles.profiles[indexPerson!]
        let vkID = organizer.vkId
        let appURL = NSURL(string: "vk://vk.com/id\(vkID)")!
        let safariURL = URL(string: "https://vk.com/id\(vkID)")!

        if UIApplication.shared.canOpenURL(appURL as URL){
            UIApplication.shared.open(appURL as URL)
        } else {
            UIApplication.shared.open(safariURL)
        }
    }
    
    
    func getData(){
        let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id ==  personId})
        let organizer = Common.profiles.profiles[indexPerson!]
        self.view!.setOrganizerData(person: organizer)
    }
}

extension OrganizerScreenPresenter: OrganizerScreenInteractorOutput {
}
