//
//  AddEventInteractor.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation
import UIKit

final class AddEventInteractor {
    weak var output: AddEventInteractorOutput?
}

extension AddEventInteractor: AddEventInteractorInput {
    func addEvent(name: String, description: String, date: Date, place: String) {
            
            let client = APIClient()

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let dateString = formatter.string(from: date)
            
            let newEvent: [String: Any] = [
                "name": name,
                "description": description,
                "location": place,
                "date": dateString,
                "organizer_id": Common.myProfile.id
            ]
            
            client.postDataTask("events", data: newEvent) { (result: Result<EventResponse, Error>) in
                do {
                    let eventResponse = try result.get()
                    print(eventResponse.event)
                    client.getDataTask("events") { (result: Result<EventsResponse, Error>) in
                        do {
                            let eventsResponse = try result.get()
                            print(eventsResponse.events)
                            Common.events.listOfEvents = eventsResponse.events
                            self.output?.reloadScreens()
                        }
                        catch {
                            print(error)
                        }
                    }
                }
                catch {
                    print(error)
                }
            }

        }
    }

