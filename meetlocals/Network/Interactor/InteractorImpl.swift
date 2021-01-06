//
// Created by AkhIgor on 27.10.2020.
//

import Foundation
import VK_ios_sdk
import RxSwift

class InteractorImpl: Interactor {

    private let vkRepository = VKRepository()
    private let appRepository = AppRepository()
    private let converter = ConverterResolver(fabric: [VkConverterFactory(), JsonConverterFactory()])

    func getVkFriends() -> Observable<[VKUser]> {
        vkRepository.getFriends()
                .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
                .map { (response: VKResponse<VKApiObject>) in
                    (self.converter.convert(to: [VKUser].self, from: response.json) ?? [VKUser]())
                }
    }

    func getVkCurrentUser() -> Observable<VKUser> {
        vkRepository.getUser()
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
                .map { (response: VKResponse<VKApiObject>) in
                    (self.converter.convert(to: VKUser.self, from: response.json) ?? VKUser())
                }
    }

    func getVkUser(userId: String) -> Observable<VKUser> {
        let userIdsParam = ["user_ids": userId]
        return vkRepository.getUser(userIdsParam)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
                .map { (response: VKResponse<VKApiObject>) in
                    (self.converter.convert(to: VKUser.self, from: response.json) ?? VKUser())
                }
    }

    func getAppUsers() -> Observable<[AppUser]> {
        return appRepository.getUsers()
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
                .map { response in
                    let jsonString = String(data: response, encoding: .utf8)
                    return (self.converter.convert(to: [AppUser].self, from: jsonString) ?? [AppUser]())
                }
    }
}
