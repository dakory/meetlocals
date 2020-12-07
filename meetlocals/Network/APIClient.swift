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

    func getDataTask<T: Decodable>(_ path: String, completion: @escaping (Result<T, Error>) -> Void) {
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


    func postDataTask<T: Decodable>(_ path: String, data: [String: Any],
                                    completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = makeURL(path: path) else {
            completion(.failure(DataTaskErrors.badURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data)
        }
        catch {
            completion(.failure(error))
            return
        }

        let task = self.session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                do {
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


    func putDataTask<T: Decodable>(_ path: String, data: [String: Any],
                                   completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = makeURL(path: path) else {
            completion(.failure(DataTaskErrors.badURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data)
        }
        catch {
            completion(.failure(error))
            return
        }

        let task = self.session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                do {
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


    func deleteDataTask(_ path: String,
                        completion: @escaping (Result<Any, Error>) -> Void) {
        guard let url = makeURL(path: path) else {
            completion(.failure(DataTaskErrors.badURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let task = self.session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data)

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

// let client = APIClient()


// Получение event
//client.getDataTask("events/1") { (result: Result<EventResponse, Error>) in
//    do {
//        let eventResponse = try result.get()
//        print(eventResponse.event)
//    }
//    catch {
//        print(error)
//    }
//}


// Получение events
//client.getDataTask("events") { (result: Result<EventsResponse, Error>) in
//    do {
//        let eventsResponse = try result.get()
//        print(eventsResponse.events)
//    }
//    catch {
//        print(error)
//    }
//}


// Добавление event
//let newEvent: [String: Any] = [
//    "name": "Skiing in the Mountains",
//    "description": "Lets rock the Rock!",
//    "location": "Alps",
//    "date": "2021-01-23T10:00:00",
//    "organizer_id": 2
//]
//
//client.postDataTask("events", data: newEvent) { (result: Result<EventResponse, Error>) in
//    do {
//        let eventResponse = try result.get()
//        print(eventResponse.event)
//    }
//    catch {
//        print(error)
//    }
//}


// Изменение event
//let updatesToEvent: [String: Any] = [
//    "location": "Sochi"
//]
//
//client.putDataTask("events/4", data: updatesToEvent) { (result: Result<EventResponse, Error>) in
//    do {
//        let eventResponse = try result.get()
//        print(eventResponse.event)
//    }
//    catch {
//        print(error)
//    }
//}


// Удаление event
//client.deleteDataTask("events/3") { (result: Result<Any, Error>) in
//    do {
//        let response = try result.get()
//        print(response)
//    }
//    catch {
//        print(error)
//    }
//}




// Получение user
//client.getDataTask("users/4") { (result: Result<ProfileResponse, Error>) in
//    do {
//        let profileResponse = try result.get()
//        print(profileResponse.profile)
//    }
//    catch {
//        print(error)
//    }
//}


// Получение users
//client.getDataTask("users") { (result: Result<ProfilesResponse, Error>) in
//    do {
//        let profilesResponse = try result.get()
//        print(profilesResponse.profiles)
//    }
//    catch {
//        print(error)
//    }
//}


// Добавление user
//let newUser = [
//    "name": "James Carlson",
//    "description": "I'm not the Carlson that lives on the roof",
//    "location": "Czech"
//]
//
//client.postDataTask("users", data: newUser) { (result: Result<ProfileResponse, Error>) in
//    do {
//        let profileResponse = try result.get()
//        print(profileResponse.profile)
//    }
//    catch {
//        print(error)
//    }
//}


//Изменение user
//let updatesToUser: [String: Any] = [
//    "description": "I'm not the Carlson that lives on the roof. Certainly :)"
//]
//
//client.putDataTask("users/4", data: updatesToUser) { (result: Result<ProfileResponse, Error>) in
//    do {
//        let profileResponse = try result.get()
//        print(profileResponse.profile)
//    }
//    catch {
//        print(error)
//    }
//}


//Удаление user
//client.deleteDataTask("users/5") { (result: Result<Any, Error>) in
//    do {
//        let response = try result.get()
//        print(response)
//    }
//    catch {
//        print(error)
//    }
//}