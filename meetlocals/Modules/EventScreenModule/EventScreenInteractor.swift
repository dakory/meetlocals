import Foundation
import UIKit


final class EventScreenInteractor {
    weak var output: EventScreenInteractorOutput?
}



extension EventScreenInteractor: EventScreenInteractorInput {
    func addOrDeleteDataNewMember(eventId: Int) {
        let client = APIClient()
        let indexEvent = Common.events.listOfEvents.firstIndex(where: { $0.id == eventId })
        
        var newIdParticipateEvents = Common.events.listOfEvents[indexEvent!].idMembers
        let id = Common.events.listOfEvents[indexEvent!].id

        if !Common.events.listOfEvents[indexEvent!].idMembers.contains(Common.myProfile.id) {
            newIdParticipateEvents.append(Common.myProfile.id)
            }
        else {
            let index = Common.events.listOfEvents[indexEvent!].idMembers.firstIndex(where: { $0 == Common.myProfile.id })
            newIdParticipateEvents.remove(at: index!)
        }
                
        let updatesToEvent: [String: Any] = [
            "members": newIdParticipateEvents
        ]
                
        client.putDataTask("events/\(String(describing: id))", data: updatesToEvent) { (result: Result<EventResponse, Error>) in
            do {
                let eventResponse = try result.get()
                print(eventResponse.event)

                client.getDataTask("events/\(String(describing: id))") { (result: Result<EventResponse, Error>) in
                    do {
                        let eventResponse = try result.get()
                        print(eventResponse.event)
                        Common.events.listOfEvents[indexEvent!] = eventResponse.event
                        self.output?.checkMembership()
                    }
                    catch {
                        print(error)
                    }
                }
            }
            catch {
                print(error)
            }
        }
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
    
    func deleteEvent(eventId: Int) {
        let client = APIClient()
        client.deleteDataTask("events/\(eventId)") { (result: Result<Any, Error>) in
            do {
                let response = try result.get()
                print(response)
                client.getDataTask("events") { (result: Result<EventsResponse, Error>) in
                    do {
                        let eventsResponse = try result.get()
                        print(eventsResponse.events)
                        Common.events.listOfEvents = eventsResponse.events
                        self.output?.reloadScreens()
                    }
                    catch {
                        print(error)
                    }
                }
            }
            catch {
                print(error)
            }
        }
        print("Мероприятие удалено")
        
    }
}

