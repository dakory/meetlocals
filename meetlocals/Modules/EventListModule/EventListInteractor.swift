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
    
    func fetchEvents() {
        
        self.output?.didLoad(events: Common.events.listOfEvents)
        
    }
}

