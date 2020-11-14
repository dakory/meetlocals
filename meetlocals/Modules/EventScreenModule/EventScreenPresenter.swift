import Foundation
import UIKit


final class EventScreenPresenter {
    var organizerID: Int?
    var eventId: Int?

	weak var view: EventScreenViewInput?
    weak var moduleOutput: EventScreenModuleOutput?
    
	private let router: EventScreenRouterInput
	private let interactor: EventScreenInteractorInput
    
    init(router: EventScreenRouterInput, interactor: EventScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventScreenPresenter: EventScreenModuleInput {

}

extension EventScreenPresenter: EventScreenViewOutput {
    func getData(){
        let event = interactor.getInfoOfEvent(eventId: eventId!)   //обращаемся к interactor для получения информации и мероприятии
        let person = interactor.getInfoOrganizer(id: event.idOrganizer)
        organizerID = person.id
        eventId = event.id
        self.view!.setEventAndOrganizerData(person, event)
    }
    
    func singUpForEvent(){
        interactor.addDataNewMember(eventId: eventId!)
    }
    
    func checkMembership(){
        let check = interactor.checkMembershipData(eventId: eventId!)
        if check {
            self.view!.setButtonOff()
        }
        else {
            self.view!.setButtonOn()
        }
    }
    
    func goToOrganizerScreen(){
        router.organizerScreen(vc: self.view as! EventScreenViewController, organizerID: organizerID!)
    }

}

extension EventScreenPresenter: EventScreenInteractorOutput {
}

extension Date {
    func dayMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        return dateFormatter.string(from: self)
    }
}
