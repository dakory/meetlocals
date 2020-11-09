import UIKit

struct Events {
    var listOfEvents: [Event]

    mutating func post(list: Event) {
        self.listOfEvents.append(list)
    }
}


//struct EventDaniil {
//    let id: Int
//    let idOrganizer: Int
//    let idMembers: [Int]
//    let description: String
//    let place: String
//    let date: String
//}

// Оставил вариант Сони, чтобы ничего не сломалось в EventScreenModule
struct Event {
    let id: Int
    let idOrganizer: Int
    var idMembers: [Int]
    let name: String
    let description: String
    let place: String
    let date: Date
//    let userName: String
//    let eventName: String
//    let userImage: String
}
