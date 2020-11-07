//
//  EventScreenInteractor.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

final class EventScreenInteractor {
    weak var output: EventScreenInteractorOutput?
    private var events: [Event] =
        [Event(description: "1", userName: "Катя", eventName: "прогуляться в парке под покровом ночи завтра", userImage: ""),
         Event(description: "1", userName: "Саша", eventName: "прогуляться в парке", userImage: ""),
         Event(description: "1", userName: "Вася", eventName: "прогуляться в парке", userImage: ""),
         Event(description: "1", userName: "Петя", eventName: "прогуляться в парке", userImage: ""),
         Event(description: "1", userName: "Ира", eventName: "прогуляться в парке", userImage: ""),
         Event(description: "1", userName: "Ира", eventName: "прогуляться в парке", userImage: ""),
        Event(description: "1", userName: "Ира", eventName: "прогуляться в парке", userImage: ""),
        Event(description: "1", userName: "Ира", eventName: "прогуляться в парке", userImage: "")]
}

extension EventScreenInteractor: EventScreenInteractorInput {
    func fetchEvents() {
        self.output?.didLoad(events: self.events)
    }
}

