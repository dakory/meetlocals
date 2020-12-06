//
// Created by Dmitry Koryakin on 05.12.2020.
//

import Foundation

class APIClient {

    private let session = URLSession(configuration: .default)

    private let baseComponents: URLComponents = {
        var baseComponents = URLComponents()

        baseComponents.scheme = "http"
        baseComponents.host = "api.shlyapa.fun"

        return baseComponents
    }()

    private let jsonDecoder: JSONDecoder = {
        let result = JSONDecoder()
        result.keyDecodingStrategy = .convertFromSnakeCase



        return result
    }()

    func dataTask<T: Decodable>(_ path: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = self.makeURL(path: path) else {
            completion(.failure(DataTaskErrors.badURL))
            return
        }

        let request = URLRequest(url: url)

        let task = self.session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                do {
                    //let result = try self.jsonDecoder.decode(T.self, from: data)
                    //print(String(data: data, encoding: .utf8))
                    let result = try self.jsonDecoder.decode(T.self, from: data)

                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                }
                catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(DataTaskErrors.responseHasNoData))
                }
            }

        }
        task.resume()
    }

    private func makeURL(path: String) -> URL? {
        var result = self.baseComponents
        result.path = "/\(path)"
        return result.url
    }

    enum DataTaskErrors: Error {
        case badURL, responseHasNoData
    }
}


// Пользоваться так:
//let client = APIClient()

//client.dataTask("events/1") { (result: Result<EventApiWrapper, Error>) in
//    print(result)
//}
