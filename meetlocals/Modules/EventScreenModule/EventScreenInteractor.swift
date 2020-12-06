import Foundation
import UIKit


final class EventScreenInteractor {
    weak var output: EventScreenInteractorOutput?
}



extension EventScreenInteractor: EventScreenInteractorInput {

    

    func addOrDeleteDataNewMember(eventId: Int) {
        let indexEvent = Common.events.listOfEvents.firstIndex(where: { $0.id == eventId })
        if !Common.events.listOfEvents[indexEvent!].idMembers.contains(Common.myProfile.id) {
            Common.events.listOfEvents[indexEvent!].idMembers.append(Common.myProfile.id)
            }
        else {
            let index = Common.events.listOfEvents[indexEvent!].idMembers.firstIndex(where: { $0 == Common.myProfile.id })
            Common.events.listOfEvents[indexEvent!].idMembers.remove(at: index!)
        }
        print(Common.events.listOfEvents[indexEvent!].idMembers)
    }
    
    func checkMembershipData(eventId: Int) -> Bool {
        let indexEvent = Common.events.listOfEvents.firstIndex(where: { $0.id == eventId })
        if Common.events.listOfEvents[indexEvent!].idMembers.contains(Common.myProfile.id) {
            return true
        }
        else {
            return false
        }
    }
    
    func getInfoOfEvent(eventId: Int) -> Event {
        let indexEvent = Common.events.listOfEvents.firstIndex(where: { $0.id == eventId })
        return Common.events.listOfEvents[indexEvent!]
    }
        
    func getInfoOrganizer(id: Int) -> Profile { //по id находим организатора мероприятия
        let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id == id })
        return Common.profiles.profiles[indexPerson!]
    }
}

