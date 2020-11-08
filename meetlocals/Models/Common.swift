import UIKit
import Foundation



class Common: NSObject { //какие-то данные с БД
    
    static var profiles = Profiles(profiles: [])
    static var events = Events(listOfEvents: [])

    
    class func generateProfilesData() {
        let profile1 = Profile(id: 0, name: "Кристиан", surname: "Бейл", isMale: true, avatarUrl: "exampleImageOfPerson", idOrganizedEvents: [], idParticipateEvents: [])
        let profile2 = Profile(id: 1, name: "Бен", surname: "Аффлек", isMale: true, avatarUrl: "exampleImageOfPerson2", idOrganizedEvents: [], idParticipateEvents: [])
        self.profiles = Profiles(profiles: [profile1, profile2])
    }
    
    class func generateEventsData() {
        let event1 = Event(id: 0, idOrganizer: 0, idMembers: [], name: "Прогулка",
                description: "Хочу просто погулять в компании молодых людей", place: "Москва, Газетный переулок, 4", date: Date(timeIntervalSinceReferenceDate: -123456789.0))
        let event2 = Event(id: 1, idOrganizer: 1, idMembers: [], name: "Фестиваль",
                           description: "Ищу компанию для похода на фестиваль из 4 человек. Хочу пообщаться и найти новых друзей", place: "Москва, Брюсов переулок, 6", date: Date(timeIntervalSinceReferenceDate: -123456789.0))
        self.events = Events(listOfEvents: [event1, event2])
    }
}
