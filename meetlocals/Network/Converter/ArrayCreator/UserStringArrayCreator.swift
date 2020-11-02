//
// Created by AkhIgor on 01.11.2020.
//

import Foundation
import VK_ios_sdk

class UserStringArrayCreator {

    private let DOMAIN = "domain = "
    private let FIRST_NAME = "\"first_name\" = "
    private let LAST_NAME = "\"last_name\" = "
    private let TRACK_CODE = "\"track_code\" = "
    private let ID = "id = "

    //TODO определиться какие поля обязательные, а какие могут и не прийти
    func create(from: [String]) -> VKUser {
        let id = from[0].string(after: ID)
        let domain = from[1].string(after: DOMAIN)
        let firstName = from[2].string(after: FIRST_NAME)
        let lastName = from[3].string(after: LAST_NAME)
        let trackCode = from[4].string(after: TRACK_CODE) //хз что это, поэтому не стал убирать окончательно
        return createUser(id: id, firstName: firstName, lastname: lastName, domain: domain)
    }

    private func createUser(id: String, firstName: String, lastname: String, domain: String) -> VKUser {
        let user = VKUser()
        user.id = NSNumber(value: Int(id)!)
        user.first_name = firstName
        user.last_name = lastname
        user.domain = domain
        print("user created")
        return user
    }
}
