import Foundation

struct Profile: Codable {
    let id: Int
    let vkId: Int
    let name: String
    let sex: Int
    let birthDate: Date?
    let description: String?
    let avatarUrl: String?
    let idOrganizedEvents: [Int]
    let idParticipateEvents: [Int]


    private enum CodingKeys : String, CodingKey {
        case id = "_id"
        case vkId = "vk_id"
        case name
        case sex
        case birthDate = "birth_date"
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

