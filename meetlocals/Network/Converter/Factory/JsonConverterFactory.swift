//
// Created by AkhIgor on 29.10.2020.
//

import Foundation

class JsonConverterFactory: ConverterFactory {

    let jsonConverters: [Converter]

    init() {
        jsonConverters = [JsonUserArrayConverter(), JsonUserConverter()]
    }

    func converters() -> [Converter] {
        jsonConverters
    }
}
