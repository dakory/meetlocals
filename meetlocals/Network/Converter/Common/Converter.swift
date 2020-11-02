//
// Created by AkhIgor on 29.10.2020.
//

import Foundation

protocol Converter {

    func canBeAppliedTo<To>(_ type: To.Type) -> Bool

    func convert<To>(_ from: String) -> To
}

extension String {

    func string(after: String) -> String {
        let range = after.endIndex..<index(before: endIndex)
        return String(self[range])
    }
}
