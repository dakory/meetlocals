//
// Created by 17099611 on 12.11.2020.
//

import Foundation
import VK_ios_sdk

class VkUserConverter: Converter {

    private let FIRST_NODE = 2
    private let userCreator = UserStringArrayCreator()

    func canBeAppliedTo<To>(_ type: To.Type) -> Bool {
        VKUser.self == type
    }

    func convert<To>(_ from: String) -> To {
        print(from)

        var user = VKUser()
        let data = splitToArray(initialData: from)
        do {
            try user = getUser(data: data)
        } catch {
            print(error)
        }
        return user as! To
    }

    private func splitToArray(initialData: String) -> [String] {
        let buffData = initialData.split(separator: "\n").map(String.init)
        var data = [String]()
        for line in buffData {
            data.append(line.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        return data
    }

    private func getUser(data: [String]) throws -> VKUser {
        var user: VKUser

        let nodeIndex = FIRST_NODE
        do {
            let domain = data[nodeIndex]
            let firstName = data[nodeIndex + 1]
            let id = data[nodeIndex + 2]
            let lastName = data[nodeIndex + 3]
            let photo_200 = data[nodeIndex + 4]

            let userNode: [String] = [id, domain, firstName, lastName, photo_200, "trackCode"]
            user = userCreator.create(from: userNode)
        }

        return user
    }
}
