//
// Created by Dmitry Koryakin on 05.12.2020.
//

import Foundation

final class APIClient {

    private let session = URLSession(configuration: .default)

    private let baseComponents: URLComponents = {
        var baseComponents = URLComponents()

        baseComponents.scheme = "http"
        baseComponents.host = "api.shlyapa.fun"

        return baseComponents
    }()

    private let jsonDecoder: JSONDecoder = {
        let result = JSONDecoder()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        result.dateDecodingStrategy = .formatted(dateFormatter)


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
//                    print(String(data: data, encoding: .utf8))
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

//let client = APIClient()


// Получение event
//client.dataTask("events/1") { (result: Result<EventResponse, Error>) in
//    do {
//        let eventResponse = try result.get()
//        print(eventResponse.event)
//    }
//    catch {
//        print(error)
//    }
//}


// Получение events
//client.dataTask("events") { (result: Result<EventsResponse, Error>) in
//    do {
//        let eventsResponse = try result.get()
//        print(eventsResponse.events)
//    }
//    catch {
//        print(error)
//    }
//}


// Получение user
//client.dataTask("users/1") { (result: Result<ProfileResponse, Error>) in
//    do {
//        let profileResponse = try result.get()
//        print(profileResponse.profile)
//    }
//    catch {
//        print(error)
//    }
//}


// Получение users
//client.dataTask("users") { (result: Result<ProfilesResponse, Error>) in
//    do {
//        let profilesResponse = try result.get()
//        print(profilesResponse.profiles)
//    }
//    catch {
//        print(error)
//    }
//}