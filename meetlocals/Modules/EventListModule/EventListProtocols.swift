//
//  EventListProtocols.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

protocol EventListModuleInput {
    var moduleOutput: EventListModuleOutput? { get }
}

protocol EventListModuleOutput: class {
    
}

protocol EventListViewInput: class {
    func set(viewModels: [EventViewModel])
    func updateList()
    func selectingScreenListType(type: TypeOfListScreen)
}

protocol EventListViewOutput: class {
    func viewDidLoad()
    func didTabEvent(meetingID: Int)
}

protocol EventListInteractorInput: class {
    func fetchEvents(type: TypeOfListScreen)
}

protocol EventListInteractorOutput: class {
    func didLoad(events: [Event])
}

protocol EventListRouterInput: class {
    func goToEventScreen(vc: EventListController, meetingID: Int)
}

