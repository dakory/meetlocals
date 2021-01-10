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
    func deleteEvent() {
        print("Перешли")
        let alertController = UIAlertController.init(title: "Вы точно хотите удалить событие?", message: "Его невозможно будет восстановить", preferredStyle: .alert)

        let YesAction = UIAlertAction(title: "Да", style: .default) { action in
            let event = self.interactor.getInfoOfEvent(eventId: self.eventId!)
            self.interactor.deleteEvent(eventId: event.id)
        }
        
        let NoAction = UIAlertAction(title: "Нет", style: .default) { action in
            (self.view as! EventScreenViewController).navigationController?.navigationBar.isUserInteractionEnabled = true
        }

        alertController.addAction(YesAction)
        alertController.addAction(NoAction)
        (self.view as! EventScreenViewController).present(alertController, animated: true)

    }
    
    func checkMembershipPresenter(){
        checkMembership()
    }
    
    func checkCurrentUserIsOrganizer() -> Bool {
        let event = interactor.getInfoOfEvent(eventId: eventId!)
        let person = interactor.getInfoOrganizer(id: event.idOrganizer)
        organizerID = person.id
        return organizerID == Common.myProfile.id
    }
    
    func getData(){
        let event = interactor.getInfoOfEvent(eventId: eventId!)
        let person = interactor.getInfoOrganizer(id: event.idOrganizer)
        organizerID = person.id
        organizerVkID  = person.vkId
        eventId = event.id
        self.view!.setEventAndOrganizerData(person, event)
    }
    
    func singUpForEvent(){
        interactor.addOrDeleteDataNewMember(eventId: eventId!)
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
    
    func goToProfile(id: Int?) {
        router.organizerScreen(vc: self.view as! EventScreenViewController, organizerID: id!)
    }
}

extension EventScreenPresenter: EventScreenInteractorOutput {
    func checkMembership(){
        let check = interactor.checkMembershipData(eventId: eventId!)
        self.view!.setButton(check)
        self.view!.reloadMembers()
        let vc = self.view as! EventScreenViewController
        let participatingListNavigationControllers  = vc.tabBarController!.viewControllers![3] as! UINavigationController
        let participatingListNavigationController = participatingListNavigationControllers.viewControllers[0] as! EventListController
        participatingListNavigationController.updateList()
    }
    
    func reloadScreens(){
        let listNavigationControllers  = (self.view as! EventScreenViewController).tabBarController!.viewControllers![0] as! UINavigationController
        let listNavigationController = listNavigationControllers.viewControllers[0] as! EventListController
        listNavigationController.updateList()
                                
        let organizingListNavigationControllers  = (self.view as! EventScreenViewController).tabBarController!.viewControllers![1] as! UINavigationController
        let organizingListNavigationController = organizingListNavigationControllers.viewControllers[0] as! EventListController
        organizingListNavigationController.updateList()
        
        let participatingListNavigationControllers  = (self.view as! EventScreenViewController).tabBarController!.viewControllers![3] as! UINavigationController
        let participatingListNavigationController = participatingListNavigationControllers.viewControllers[0] as! EventListController
        participatingListNavigationController.updateList()
        self.router.deleteEvent()
    }
}

extension Date {
    func dayMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}
