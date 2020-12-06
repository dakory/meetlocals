//
// Created by AkhIgor on 29.10.2020.
//

import Foundation
import VK_ios_sdk

class ConverterResolver {

    var converters = [Converter]()

    init(fabric: [ConverterFactory]) {
        fabric.forEach { factory in
            self.converters.append(contentsOf: factory.converters())
        }
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
