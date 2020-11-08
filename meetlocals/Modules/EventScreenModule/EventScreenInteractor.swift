import Foundation

final class EventScreenInteractor {
    weak var output: EventScreenInteractorOutput?
}



extension EventScreenInteractor: EventScreenInteractorInput {

    
    func getInfoOfEvent() -> Event { //функция, для получения даных с Common
        Common.generateEventsData()   //подгружаем общий список мероприятий
        Common.generateProfilesData() //подгружаем общий список пользователей
        
        let indexEvent = Common.events.listOfEvents.firstIndex(where: { $0.id == EventScreenRouter.eventID })
        return Common.events.listOfEvents[indexEvent!]
    }
        
    func getInfoOrganizer(id: Int) -> Profile { //по id находим организатора мероприятия
        let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id == id })
        return Common.profiles.profiles[indexPerson!]
    }
}

