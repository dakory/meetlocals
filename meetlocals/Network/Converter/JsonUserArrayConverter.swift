//
// Created by AkhIgor on 31.10.2020.
//

import Foundation
import VK_ios_sdk

class JsonUserArrayConverter: Converter {

    private let COUNT = "count = "
    private let FIRST_NODE = 4
    private let PERIOD_CYCLE = 7
    private let FIRST_USER_FIELD = "domain"

    private let userCreator = UserStringArrayCreator()

    func canBeAppliedTo<To>(_ type: To.Type) -> Bool {
        [VKUser].self == type
    }

    func convert<To>(_ from: String) -> To {
        print(from)
        var users = [VKUser]()
        let data = splitToArray(initialData: from)
        do {
            try users = getUsers(data: data)
        } catch {
            print(error)
        }
        return users as! To
    }


    private func getTotalCount(countLine: String) throws -> Int {
        if (countLine.starts(with: COUNT)) {
            return Int(countLine.string(after: COUNT))!
        } else {
            throw ConvertationError(cause: "Count of nodes is expected")
        }
    }

    private func splitToArray(initialData: String) -> [String] {
        let buffData = initialData.split(separator: "\n").map(String.init)
        var data = [String]()
        for line in buffData {
            data.append(line.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        return data
    }

    private func getUsers(data: [String]) throws -> [VKUser] {
        var users = [VKUser]()
//        let countOfNodes = try getTotalCount(countLine: data[1])
//        print("countOfNodes = \(countOfNodes)")

        var nodeIndex = FIRST_NODE
        while (data[nodeIndex].starts(with: FIRST_USER_FIELD)) {
            let domain = data[nodeIndex]
            let firstName = data[nodeIndex + 1]
            let id = data[nodeIndex + 2]
            let lastName = data[nodeIndex + 3]
//            let trackCode = data[nodeIndex + 4]
            nodeIndex += PERIOD_CYCLE

            let userNode: [String] = [id, domain, firstName, lastName, ""]
            users.append(userCreator.create(from: userNode))
        }

        return users
    }
}
