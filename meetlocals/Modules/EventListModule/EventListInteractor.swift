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
            self.output?.didLoad(events: Common.events.listOfEvents)
        }
        else if type == .participating {
            self.output?.didLoad(events:
                                    Common.events.listOfEvents.filter({$0.idMembers.contains(Common.myProfile.id)}))
        }
        else if type == .organizing {
            self.output?.didLoad(events:
                                    Common.events.listOfEvents.filter({$0.idOrganizer == Common.myProfile.id}))
        }
    }
}

