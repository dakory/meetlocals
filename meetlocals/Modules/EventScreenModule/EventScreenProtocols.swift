//
//  EventScreenProtocols.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

protocol EventScreenModuleInput {
    var moduleOutput: EventScreenModuleOutput? { get }
}

protocol EventScreenModuleOutput: class {
    
}

protocol EventScreenViewInput: class {
    func set(viewModels: [EventViewModel])
}

protocol EventScreenViewOutput: class {
    func viewDidLoad()
    func didTabAddEvent()
    func didTabEvent()
}

protocol EventScreenInteractorInput: class {
    func fetchEvents()
}

protocol EventScreenInteractorOutput: class {
    func didLoad(events: [Event])
}

protocol EventScreenRouterInput: class {
    func showAddEvent()
    func showEvent()
    
}

