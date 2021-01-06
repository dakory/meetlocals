import Foundation
import UIKit


final class EventScreenPresenter {
    var organizerID: Int?
    var organizerVkID: Int?
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

    func checkMembershipPresenter(){
        checkMembership()
    }
    
    func getData(){
        let event = interactor.getInfoOfEvent(eventId: eventId!)   //обращаемся к interactor для получения информации и мероприятии
        let person = interactor.getInfoOrganizer(id: event.idOrganizer)
        organizerID = person.id
        organizerVkID  = person.vkId
        eventId = event.id
        self.view!.setEventAndOrganizerData(person, event)
    }
    
    func singUpForEvent(){
        interactor.addOrDeleteDataNewMember(eventId: eventId!)
    //    router.updateScreens(vc: self.view as! EventScreenViewController)
    }

    
    func goToOrganizerScreen(){
        router.organizerScreen(vc: self.view as! EventScreenViewController, organizerID: organizerID!)
    }
    
    func goToVkPresenter(toOrganizer: Bool, id: Int?) {
        if toOrganizer {
            router.goToVk(id: organizerVkID!) }
        else {
            router.goToVk(id: id!)
        }
    }
}

extension EventScreenPresenter: EventScreenInteractorOutput {
    func checkMembership(){
        let check = interactor.checkMembershipData(eventId: eventId!)
        self.view!.setButton(check)
        self.view!.reloadMembers()
        let vc = self.view as! EventScreenViewController
        let participatingListNavigationControllers  = vc.tabBarController!.viewControllers![2] as! UINavigationController
        let participatingListNavigationController = participatingListNavigationControllers.viewControllers[0] as! EventListController
        participatingListNavigationController.updateList()
    }
    
}

extension Date {
    func dayMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}
