//
// Created by AkhIgor on 27.10.2020.
//

import Foundation
import VK_ios_sdk
import RxSwift

class InteractorImpl: Interactor {

    private let repository = Repository()
    private let converter = ConverterResolver(fabric: JsonConverterFactory())

    func getFriends() -> Observable<[VKUser]> {
        repository.getFriends()
                .map { (response: VKResponse<VKApiObject>) in
                    (self.converter.convert(to: [VKUser].self, from: response.json) ?? [VKUser]())
                }
    }
}