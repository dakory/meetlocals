struct Profile: Codable {
    let id: Int
    let name: String
    let description: String?
    let avatarUrl: String?
    let idOrganizedEvents: [Int]
    let idParticipateEvents: [Int]

    // изменения полей структуры по сравнению с прошлой версией:
    // -isMale
    // -surname
    // +description

    private enum CodingKeys : String, CodingKey {
        case id = "_id"
        case name
        case description
        case avatarUrl = "avatar_url"
        case idOrganizedEvents = "is_organizer__events"
        case idParticipateEvents = "is_member__events"
    }
}

struct ProfileResponse: Codable {
    let profile: Profile

    private enum CodingKeys : String, CodingKey {
        case profile = "user"
    }
}

struct Profiles {
    var profiles: [Profile]

    mutating func post(profile: Profile) {
        self.profiles.append(profile)
    }
}

struct ProfilesResponse: Codable {
    let profiles: [Profile]

    private enum CodingKeys : String, CodingKey {
        case profiles = "users"
    }
}

