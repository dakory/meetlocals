//
// Created by AkhIgor on 27.10.2020.
//

import Foundation
import VK_ios_sdk
import RxSwift

class VKRepository {

    public func getFriends(_ params: [String: String] = ["fields": "domain", "count": "3"]) -> Observable<VKResponse<VKApiObject>> {
        let vkRequest = VKApi.friends().get(params)
        return tryToSend(request: vkRequest)
    }

    public func getUser(_ additionalParams: [String: String]? = nil) -> Observable<VKResponse<VKApiObject>> {
        var params: [String: String] = ["fields": "domain, photo_200", "name_case": "Nom"]
        if (additionalParams != nil) {
            additionalParams?.forEach { key, value in
                params.updateValue(value, forKey: key)
            }
        }
        let vkRequest = VKApi.users().get(params)
        return tryToSend(request: vkRequest)
    }

    private func tryToSend(request: VKRequest?) -> Observable<VKResponse<VKApiObject>> {
        request?.makeRequest() ?? Observable.error(NetError(cause: "Request cannot be null"))
    }
}

extension VKRequest {

    func makeRequest() -> Observable<VKResponse<VKApiObject>> {
        Observable<VKResponse>.create { (subscriber: AnyObserver) in
            self.execute(resultBlock: { (response: VKResponse<VKApiObject>?) in
                if (response != nil) {
                    subscriber.postResponse(response!)
                }
            }, errorBlock: { (error: Error?) in
                if (error != nil) {
                    subscriber.onError(error!)
                }
            })
            return Disposables.create()
        }
    }
}

extension AnyObserver {

    func postResponse(_ response: Element) {
        onNext(response)
        onCompleted()
    }
}