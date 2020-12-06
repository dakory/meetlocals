import Foundation

struct Events: Codable {
    var listOfEvents: [Event]

    mutating func post(list: Event) {
        self.listOfEvents.append(list)
    }
}

struct EventApiWrapper: Codable {
    let event: Event
}

struct Event: Codable {
    let id: Int
    let idOrganizer: Int
    var idMembers: [Int]
    let name: String
    let description: String
    let place: String
    let date: Date

    private enum CodingKeys : String, CodingKey {
        case id = "_id", idOrganizer = "organizer_id", idMembers = "members", name, description, place = "location", date
    }
}