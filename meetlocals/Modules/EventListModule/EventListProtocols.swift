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
}

protocol EventListViewOutput: class {
    func viewDidLoad()
    func didTabAddEvent()
    func didTabEvent()
}

protocol EventListInteractorInput: class {
    func fetchEvents()
}

protocol EventListInteractorOutput: class {
    func didLoad(events: [Event])
}

protocol EventListRouterInput: class {
    func showAddEvent()
    func showEvent()
    
}
