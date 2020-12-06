//
// Created by AkhIgor on 27.10.2020.
//

import Foundation
import VK_ios_sdk
import RxSwift

protocol Interactor {

    func getVkFriends() -> Observable<[VKUser]>

    func getVkCurrentUser() -> Observable<VKUser>

    func getVkUser(userId: String) -> Observable<VKUser>

    func getAppUsers() -> Observable<[AppUser]>
}
