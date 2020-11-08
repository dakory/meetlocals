import UIKit

struct Events {
    var listOfEvents: [EventDaniil]

    mutating func post(list: EventDaniil) {
        self.listOfEvents.append(list)
    }
}


struct EventDaniil {
    let id: Int
    let idOrganizer: Int
    let idMembers: [Int]
    let description: String
    let place: String
    let date: String
}

// Оставил вариант Сони, чтобы ничего не сломалось в EventScreenModule
struct Event {
    let id: Int
    let idOrganizer: Int
    let idMembers: [Int]
    let name: String
    let description: String
    let place: String
    let date: Date
//    let userName: String
//    let eventName: String
//    let userImage: String
}
