//
//  EventListInteractor.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

final class EventListInteractor {
    weak var output: EventListInteractorOutput?
    // TODO: Подгружать события.
//    private var events: [Event] =
//        [Event(id: 1, idOrganizer: 1, idMembers: [], name: "1", description: "1", place: "1", date: NSDate.now), Event(id: 1, idOrganizer: 1, idMembers: [], name: "1", description: "1", place: "1", date: NSDate.now)]
}

extension EventListInteractor: EventListInteractorInput {
    
    func fetchEvents() {
        Common.generateEventsData()   //подгружаем общий список мероприятий
        Common.generateProfilesData() //подгружаем общий список пользователей
        
        self.output?.didLoad(events: Common.events.listOfEvents)
        
    }
}

