//
//  EventListInteractor.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

final class EventListInteractor {
    weak var output: EventListInteractorOutput?
    
}
extension EventListInteractor: EventListInteractorInput {
    
    
    func fetchEvents(type: TypeOfListScreen) {
        if type == .common {
            self.output?.didLoad(events: Common.events.listOfEvents.reversed())
        }
        else if type == .participating {
            self.output?.didLoad(events:
                                    Common.events.listOfEvents.filter({$0.idMembers.contains(Common.myProfile.id)}).reversed())
        }
        else if type == .organizing {
            self.output?.didLoad(events:
                                    Common.events.listOfEvents.filter({$0.idOrganizer == Common.myProfile.id}).reversed())
        }
    }
    
    func reloadEventsWithTheSearch(text: String) {
        if text.isEmpty || text == "" {
            fetchEvents(type: .common)
        }
        else {
        self.output?.didLoad(events: Common.events.listOfEvents.reversed().filter({$0.name.contains(text)}))
        }
    }
}

