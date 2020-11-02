//
// Created by AkhIgor on 01.11.2020.
//

import Foundation

class ConvertationError: Error {
    let cause: String

    init(cause: String) {
        self.cause = cause
    }
}
