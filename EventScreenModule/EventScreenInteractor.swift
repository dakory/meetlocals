import Foundation

final class EventScreenInteractor {
    weak var output: EventScreenInteractorOutput?
}



extension EventScreenInteractor: EventScreenInteractorInput {

    
    func getInfoOfEvent() -> Event { //функция, для получения даных с Common
        Common.generateEventsData()   //подгружаем общий список мероприятий
        Common.generateProfilesData() //подгружаем общий список пользователей
        
        let indexEvent = Common.events.listOfEvents.firstIndex(where: { $0.id == 0 })
        return Common.events.listOfEvents[indexEvent!]
    }
        
    func getInfoOrganizer(id: Int) -> Profile { //по id находим организатора мероприятия
        let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id == 0 })
        return Common.profiles.profiles[indexPerson!]
    }
        
//        func getListOfPeople() -> [Person] { //функция, для получения даных с Common
//            var peopleList = [Person]()
//            let allFruitDetail = Common.generatePersonData()
//            for item in allFruitDetail {
//                var person = Person(name: item[0], imagePerson: item[1])
//                let event = Event(data: item[2], description: item[3], place: item[4])
//                person.events.append(event)
//                peopleList.append(person)
//            }
//            return peopleList
//        }
    }

