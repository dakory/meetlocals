

import Foundation
import UIKit

private var person = Person(name: "", imagePerson: "")

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
    func sendOrganizerData(data: Person){
        (self.view as! EventScreenViewController).nameOfPerson.text = data.name
        (self.view as! EventScreenViewController).imageOfPerson.image =  data.imagePersonString
        (self.view as! EventScreenViewController).labelTime.text = data.events[0].data
        (self.view as! EventScreenViewController).labelPlace.text = data.events[0].place
        (self.view as! EventScreenViewController).labelDescription.text = data.events[0].description
    }
    
}

extension EventScreenPresenter: EventScreenViewOutput {
    func getData(){
        let peopleList = interactor.getListOfPeople()   //обращаемся к interactor для получения списка людей
      //  let firstPerson = peopleList[0]
      //  let secondPerson = peopleList[1]
        person = peopleList[0]
        sendOrganizerData(data: person)    //вызываем функцию, в которую положили
    }
    
    func singUpForEvent(){
        print("SingUpForEvent")
    }
    
    func goToOrganizerScreen(){
        router.organizerScreen(vc: self.view as! EventScreenViewController, organizer: person)
    }

}

extension EventScreenPresenter: EventScreenInteractorOutput {
}
