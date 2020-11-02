//
// Created by AkhIgor on 29.10.2020.
//

import Foundation
import VK_ios_sdk

class ConverterResolver {

    let converters: [Converter]

    init(fabric: ConverterFactory) {
        self.converters = fabric.converters()
    }

    func convert<To>(to: To.Type, from: Any?) -> To? {
        if(from == nil) {
            return nil
        }
        return (converters.first { converter in
            converter.canBeAppliedTo(to)
        }?.convert(String(describing: from!)))
    }
}
