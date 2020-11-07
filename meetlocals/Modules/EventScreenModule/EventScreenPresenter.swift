//
//  EventScreenPresenter.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

final class EventScreenPresenter {
    weak var view: EventScreenViewInput?
    weak var moduleOutput: EventScreenModuleOutput?
    
    private let router: EventScreenRouterInput
    private let interactor: EventScreenInteractorInput
    
    init(router: EventScreenRouterInput, interactor:EventScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventScreenPresenter: EventScreenModuleInput {
}

extension EventScreenPresenter: EventScreenViewOutput {
    func didTabEvent() {
        self.router.showEvent()
    }
    
    func didTabAddEvent() {
        self.router.showAddEvent()
    }
    
    
    func viewDidLoad() {
        self.interactor.fetchEvents()
    }
}

extension EventScreenPresenter: EventScreenInteractorOutput {
    func didLoad(events: [Event]) {
        let viewModels = self.makeViewModels(events: events)
        self.view?.set(viewModels: viewModels)
    }
}

private extension EventScreenPresenter {
    func makeViewModels(events: [Event]) -> [EventViewModel] {
        return events.map { EventViewModel(description: $0.description, userName: $0.userName, eventName: $0.eventName, userImage: $0.userImage) }
    }
}
