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
        let users: [AppUser] = try! JSONDecoder().decode([AppUser].self, from: data!)
        return users as! To
    }
}
