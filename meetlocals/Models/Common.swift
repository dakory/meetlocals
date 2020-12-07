import UIKit
import Foundation

enum TypeOfListScreen {
    case common
    case participating
    case organizing
}

class Common: NSObject { //какие-то данные с БД
    
    static var myProfile = Profile(id: 1, vkId: 0, name: "", sex: 0, birthDate: Date(timeIntervalSinceReferenceDate: -123456789.0), description: "", avatarUrl: "exampleImageOfPerson", idOrganizedEvents: [], idParticipateEvents: [])
//

//    static var myProfile = Profile(id: 0, vkId: 0, name: "", sex: 0, birthDate: Date(timeIntervalSinceReferenceDate: -123456789.0), description: "", avatarUrl: "", idOrganizedEvents: [], idParticipateEvents: [])
    static var profiles = Profiles(profiles: [])
    static var events = Events(listOfEvents: [])
//
//
//    class func generateProfilesData() {
//        let profile3 = Profile(id: 1, vkId: 104017770, name: "Данил Ильичев", sex: 0, birthDate: Date(timeIntervalSinceReferenceDate: -123456789.0), description: "", avatarUrl: "exampleImageOfPerson", idOrganizedEvents: [], idParticipateEvents: [])
//
//        let profile0 = Profile(id: 3, vkId: 136670638, name: "Артем Шведов", sex: 0, birthDate: Date(timeIntervalSinceReferenceDate: -123456789.0), description: "", avatarUrl: "exampleImageOfPerson", idOrganizedEvents: [0], idParticipateEvents: [0, 2])
//
//        let profile1 = Profile(id: 5, vkId: 229398885, name: "Ильяс Басманов", sex: 0, birthDate: Date(timeIntervalSinceReferenceDate: -123456789.0), description: "", avatarUrl: "exampleImageOfPerson", idOrganizedEvents: [1], idParticipateEvents: [1, 2])
//
//        let profile2 = Profile(id: 6, vkId: 317445313, name: "Богдан Никитин", sex: 0, birthDate: Date(timeIntervalSinceReferenceDate: -123456789.0), description: "", avatarUrl: "exampleImageOfPerson", idOrganizedEvents: [2], idParticipateEvents: [0, 2])
//
//        self.profiles = Profiles(profiles: [profile0, profile1, profile2, profile3])
//    }
//
//    class func generateEventsData() {
//        let event1 = Event(id: 1, idOrganizer: 3, idMembers: [3, 6], name: "Поездка на велосипеде в парке Лосиный остров",
//                description: "Хочу просто погулять в компании молодых людей", place: "Москва, Газетный переулок, 4", date: Date(timeIntervalSinceReferenceDate: -123456789.0))
//        let event2 = Event(id: 2, idOrganizer: 5, idMembers: [3, 5], name: "Фестиваль",
//                           description: "Ищу компанию для похода на фестиваль из 4 человек. Хочу пообщаться и найти новых друзей", place: "Москва, Брюсов переулок, 6", date: Date(timeIntervalSinceReferenceDate: -123456789.0))
//        let event3 = Event(id: 3, idOrganizer: 6, idMembers: [6], name: "Поход в кино",
//                           description: "Хочу сходить в кино с небольшой компанией молодых людей", place: "Москва, ул. Арбат, 9", date: Date(timeIntervalSinceReferenceDate: -123456789.0))
//        self.events = Events(listOfEvents: [event1, event2, event3])
//    }
    
    
    
//
//
//
//
//    class func generateProfilesData() {
//        let profile0 = Profile(id: 3, vkId: 3, name: "Дмитрий Корякин", sex: 0, birthDate: Date(timeIntervalSinceReferenceDate: -123456789.0), description: "", avatarUrl: "userAvatar", idOrganizedEvents: [], idParticipateEvents: [])
//
//        let profile1 = Profile(id: 0, vkId: 0, name: "Кристиан Бейл", sex: 0, birthDate: Date(timeIntervalSinceReferenceDate: -123456789.0), description: "", avatarUrl: "exampleImageOfPerson", idOrganizedEvents: [], idParticipateEvents: [])
//
//        let profile2 = Profile(id: 1, vkId: 1, name: "Бен Аффлек", sex: 0, birthDate: Date(timeIntervalSinceReferenceDate: -123456789.0), description: "", avatarUrl: "exampleImageOfPerson2", idOrganizedEvents: [], idParticipateEvents: [])
//
//        self.profiles = Profiles(profiles: [profile0, profile1, profile2])
//    }
//
//    class func generateEventsData() {
//        let event1 = Event(id: 0, idOrganizer: 0, idMembers: [0, 3], name: "Поездка на велосипеде в парке Лосиный остров",
//                description: "Хочу просто погулять в компании молодых людей", place: "Москва, Газетный переулок, 4", date: Date(timeIntervalSinceReferenceDate: -123456789.0))
//        let event2 = Event(id: 1, idOrganizer: 1, idMembers: [1], name: "Фестиваль",
//                           description: "Ищу компанию для похода на фестиваль из 4 человек. Хочу пообщаться и найти новых друзей", place: "Москва, Брюсов переулок, 6", date: Date(timeIntervalSinceReferenceDate: -123456789.0))
//        let event3 = Event(id: 2, idOrganizer: 3, idMembers: [3], name: "Поход в кино",
//                           description: "Хочу сходить в кино с небольшой компанией молодых людей", place: "Москва, ул. Арбат, 9", date: Date(timeIntervalSinceReferenceDate: -123456789.0))
//        self.events = Events(listOfEvents: [event1, event2, event3])
//    }
}
