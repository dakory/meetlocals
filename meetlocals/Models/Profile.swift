struct Profiles {
    var profiles: [Profile]

    mutating func post(profile: Profile) {
        self.profiles.append(profile)
    }
}

struct Profile {
    let id: Int
    let name: String
    let surname: String
    let isMale: Bool?
    let avatarUrl: String?
    let idOrganizedEvents: [Int]
    let idParticipateEvents: [Int]
}

