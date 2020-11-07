//
// Created by Dmitry Koryakin on 28.10.2020.
//


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
}

