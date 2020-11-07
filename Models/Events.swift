struct Events {
    var listOfEvents: [Event]

    mutating func post(list: Event) {
        self.listOfEvents.append(list)
    }
}


struct Event {
    let id: Int
    let idOrganizer: Int
    let idMembers: [Int]
    let description: String
    let place: String
    let date: String
}
