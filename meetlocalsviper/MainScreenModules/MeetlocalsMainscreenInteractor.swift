//
//  MeetlocalsMainscreenInteractor.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

final class MeetlocalsMainscreenInteractor {
    weak var output: MeetlocalsMainscreenInteractorOutput?
    private var events: [Event] = [Event(description: "1"), Event(description: "2"), Event(description: "3"), Event(description: "4"), Event(description: "5"), Event(description: "6"), Event(description: "7"), Event(description: "8"), Event(description: "9"), Event(description: "10")]
}

extension MeetlocalsMainscreenInteractor: MeetlocalsMainscreenInteractorInput {
    func fetchEvents() {
        self.output?.didLoad(events: self.events)
    }
}

