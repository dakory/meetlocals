//
// Created by 17099611 on 27.11.2020.
//

import Foundation
import RxSwift

class AppRepository {

    func getUsers() -> Observable<[AppUser]> {
        Observable.create { (subscriber: AnyObserver<[AppUser]>) in
            let session = URLSession(configuration: .default)
            var urlRequest = URLRequest(url: URL(string: "http://api.shlyapa.fun/users/1")!)

            urlRequest.httpMethod = "GET"
            urlRequest.httpBody = Data()

            session.dataTask(with: urlRequest) { (data, response, error) in
                if (response != nil) {
                    print(response)
                    subscriber.onNext(response as! [AppUser])
                    subscriber.onCompleted()
                } else if (error != nil) {
                    subscriber.onError(error!)
                }
            }.resume()

            return Disposables.create()
        }

    }

    private func processResponse<T>(subscriber: AnyObserver<T>, data: Data?, response: URLResponse?, error: Error?) {
        if (response != nil) {
            print(response)
            subscriber.onNext(response as! T)
            subscriber.onCompleted()
        } else if (error != nil) {
            subscriber.onError(error!)
        }
    }

}
