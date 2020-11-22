//
// Created by AkhIgor on 27.10.2020.
//

import Foundation
import VK_ios_sdk
import RxSwift

protocol Interactor {

    func getFriends() -> Observable<[VKUser]>

    func getCurrentUser() -> Observable<VKUser>

    func getUser(userId: String) -> Observable<VKUser>
}
