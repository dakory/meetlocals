
import Foundation

final class EventScreenInteractor {
	weak var output: EventScreenInteractorOutput?
}



extension EventScreenInteractor: EventScreenInteractorInput {

    func getListOfPeople() -> [Person] { //функция, для получения даных с Common
        var peopleList = [Person]()
        let allFruitDetail = Common.generatePersonData()
        for item in allFruitDetail {
            var person = Person(name: item[0], imagePerson: item[1])
            let event = Event(data: item[2], description: item[3], place: item[4])
            person.events.append(event)
            peopleList.append(person)
        }
        return peopleList
    }
}

