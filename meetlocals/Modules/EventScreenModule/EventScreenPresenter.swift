import Foundation
import UIKit

private var organizerID: Int = -1;
private var eventID: Int = -1;


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
        (self.view as! EventScreenViewController).labelTime.text = event.date.dayMonthYearFormat()
        (self.view as! EventScreenViewController).labelPlace.text = event.place
        (self.view as! EventScreenViewController).labelDescription.text = event.description
        

        for i in 0..<event.idMembers.count {
            print((self.view as! EventScreenViewController).stackViewMembers)
            let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id == event.idMembers[i] })!
            let imageUrl = Common.profiles.profiles[indexPerson].avatarUrl
            let imageView = UIImageView()
            imageView.image = UIImage(named: imageUrl ?? "person.circle")
            imageView.contentMode = .scaleAspectFill
            imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
        (self.view as! EventScreenViewController).stackViewMembers.addArrangedSubview(imageView)
        }
    }
}

extension EventScreenPresenter: EventScreenViewOutput {
    func getData(){
        let event = interactor.getInfoOfEvent()   //обращаемся к interactor для получения информации и мероприятии
        let person = interactor.getInfoOrganizer(id: event.idOrganizer)
        organizerID = person.id
        eventID = event.id
        sendEventAndOrganizerData(person, event)
    }
    
    func singUpForEvent(){
        interactor.addDataNewMember(eventId: eventID)
    }
    
    func checkMembership(){
        let check = interactor.checkMembershipData(eventId: eventID)
        if check {
            (self.view as! EventScreenViewController).ButtonSignUp.backgroundColor = UIColor.systemGray
            (self.view as! EventScreenViewController).ButtonSignUp.setTitleColor(UIColor.white, for: .normal)
            (self.view as! EventScreenViewController).ButtonSignUp.setTitle("Вы подали заявку", for: .normal)

            }
        else {
            (self.view as! EventScreenViewController).ButtonSignUp.backgroundColor = UIColor.systemBlue
            (self.view as! EventScreenViewController).ButtonSignUp.setTitleColor(UIColor.white, for: .normal)
            (self.view as! EventScreenViewController).ButtonSignUp.setTitle("Хочу пойти", for: .normal)
            }
            }
    
    func goToOrganizerScreen(){
        router.organizerScreen(vc: self.view as! EventScreenViewController, organizerID: organizerID)
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
