import Foundation

struct Event: Codable {
    let id: Int
    let idOrganizer: Int
    var idMembers: [Int]
    let name: String
    let description: String
    let place: String
    let date: Date

    private enum CodingKeys : String, CodingKey {
        case id = "_id"
        case idOrganizer = "organizer_id"
        case idMembers = "members"
        case name
        case description
        case place = "location"
        case date
    }
}

struct EventResponse: Codable {
    let event: Event

    private enum CodingKeys : String, CodingKey {
        case event
    }
}


struct Events: {
    var listOfEvents: [Event]

    mutating func post(list: Event) {
        self.listOfEvents.append(list)
    }
}

struct EventsResponse: Codable {
    let events: [Event]

    private enum CodingKeys : String, CodingKey {
        case events
    }
}