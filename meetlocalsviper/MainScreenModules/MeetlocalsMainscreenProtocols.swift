//
//  MeetlocalsMainscreenProtocols.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

protocol MeetlocalsMainscreenModuleInput {
    var moduleOutput: MeetlocalsMainscreenModuleOutput? { get }
}

protocol MeetlocalsMainscreenModuleOutput: class {
    
}

protocol MeetlocalsMainscreenViewInput: class {
    func set(viewModels: [EventViewModel])
}

protocol MeetlocalsMainscreenViewOutput: class {
    func viewDidLoad()
    func didTabAddEvent()
    func didTabEvent()
}

protocol MeetlocalsMainscreenInteractorInput: class {
    func fetchEvents()
}

protocol MeetlocalsMainscreenInteractorOutput: class {
    func didLoad(events: [Event])
}

protocol MeetlocalsMainscreenRouterInput: class {
    func showAddEvent()
    func showEvent()
    
}

