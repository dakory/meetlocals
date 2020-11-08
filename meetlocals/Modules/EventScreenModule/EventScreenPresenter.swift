import Foundation
import UIKit

private var organizerID: Int = -1;

final class EventScreenPresenter {
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
    func sendEventAndOrganizerData(_ person: Profile, _ event: Event){ //функция, в которую положили данные о мероприятии и его организаторе, чтобы вывести на экран
        (self.view as! EventScreenViewController).nameOfPerson.text = "\(person.name) \(person.surname)"
        (self.view as! EventScreenViewController).imageOfPerson.image = UIImage(named: person.avatarUrl!)
        (self.view as! EventScreenViewController).labelTime.text = event.date
        (self.view as! EventScreenViewController).labelPlace.text = event.place
        (self.view as! EventScreenViewController).labelDescription.text = event.description
    }
    
}

extension EventScreenPresenter: EventScreenViewOutput {
    func getData(){
        let event = interactor.getInfoOfEvent()   //обращаемся к interactor для получения информации и мероприятии
        let person = interactor.getInfoOrganizer(id: event.idOrganizer)
        organizerID = person.id
        sendEventAndOrganizerData(person, event)
    }
    
    func singUpForEvent(){
        print("SingUpForEvent")
    }
    
    func goToOrganizerScreen(){
        router.organizerScreen(vc: self.view as! EventScreenViewController, organizerID: organizerID)
    }

}

extension EventScreenPresenter: EventScreenInteractorOutput {
}
