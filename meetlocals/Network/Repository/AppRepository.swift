//
// Created by 17099611 on 27.11.2020.
//

import Foundation
import RxSwift

class AppRepository {

    func getUsers() -> Observable<Data> {
        Observable.create { (subscriber: AnyObserver<Data>) in
            let session = URLSession(configuration: .default)
            var urlRequest = URLRequest(url: URL(string: "http://api.shlyapa.fun/users/")!)

            urlRequest.httpMethod = "GET"
            urlRequest.httpBody = Data()

            session.dataTask(with: urlRequest) { (data, response, error) in
                if let data = data {
                    subscriber.onNext(data)
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
//            print(response)
            subscriber.onNext(response as! T)
            subscriber.onCompleted()
        } else if (error != nil) {
            subscriber.onError(error!)
        }
    }

}
