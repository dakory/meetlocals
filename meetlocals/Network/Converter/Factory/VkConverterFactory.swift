//
// Created by AkhIgor on 29.10.2020.
//

import Foundation

class VkConverterFactory: ConverterFactory {

    let vkConverters: [Converter]

    init() {
        vkConverters = [VkUserArrayConverter(), VkUserConverter()]
    }

    func converters() -> [Converter] {
        vkConverters
    }
}
