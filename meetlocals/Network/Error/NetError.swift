//
// Created by AkhIgor on 29.10.2020.
//

import Foundation

class NetError: Error {

    private let cause: String

    init(cause: String) {
        self.cause = cause
    }
}
