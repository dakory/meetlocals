//
// Created by 17099611 on 28.11.2020.
//

import Foundation

class JsonAppUserConverter: Converter {

    func canBeAppliedTo<To>(_ type: To.Type) -> Bool {
        [AppUser].self == type
    }

    func convert<To>(_ from: String) -> To {
        let data = from.data(using: .utf8)
        print(from)
        let usersList: AppUsers = try! JSONDecoder().decode(AppUsers.self, from: data!)
        return usersList.users as! To
    }
}
