//
// Created by AkhIgor on 29.10.2020.
//

import Foundation

class JsonConverterFactory: ConverterFactory {

    let jsonConverters: [Converter]

    init() {
        jsonConverters = [JsonAppUserConverter()]
    }

    func converters() -> [Converter] {
        jsonConverters
    }
}
