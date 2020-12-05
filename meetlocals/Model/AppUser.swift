//
// Created by 17099611 on 27.11.2020.
//

import Foundation

class AppUser: Codable {
    let id: Int
    let name: String
    let avatarUrl: String?
    let location: String
    let description: String
    let memberEventsList: [UInt64]
    let organizerEventsList: [UInt64]

//    required init()

    public init(id: Int, name: String, avatarUrl: String?, location: String, description: String, memberEventsList: [UInt64], organizerEventsList: [UInt64]) {
        self.id = id
        self.name = name
        self.avatarUrl = avatarUrl
        self.location = location
        self.description = description
        self.memberEventsList = memberEventsList
        self.organizerEventsList = organizerEventsList
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.avatarUrl, forKey: .avatar_url)
        try container.encode(self.location, forKey: .location)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.memberEventsList, forKey: .is_member_events)
        try container.encode(self.organizerEventsList, forKey: .is_organizer_events)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.avatarUrl = try container.decode(String.self, forKey: .avatar_url)
        self.location = try container.decode(String.self, forKey: .location)
        self.description = try container.decode(String.self, forKey: .description)
        self.memberEventsList = try container.decode([UInt64].self, forKey: .is_member_events)
        self.organizerEventsList = try container.decode([UInt64].self, forKey: .is_organizer_events)
    }
}

private enum CodingKeys: String, CodingKey {
    case id
    case name
    case avatar_url
    case location
    case description
    case is_member_events
    case is_organizer_events
}