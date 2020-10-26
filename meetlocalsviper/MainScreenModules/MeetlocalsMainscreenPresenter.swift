//
//  MeetlocalsMainscreenPresenter.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

final class MeetlocalsMainscreenPresenter {
    weak var view: MeetlocalsMainscreenViewInput?
    weak var moduleOutput: MeetlocalsMainscreenModuleOutput?
    
    private let router: MeetlocalsMainscreenRouterInput
    private let interactor: MeetlocalsMainscreenInteractorInput
    
    init(router: MeetlocalsMainscreenRouterInput, interactor: MeetlocalsMainscreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MeetlocalsMainscreenPresenter: MeetlocalsMainscreenModuleInput {
}

extension MeetlocalsMainscreenPresenter: MeetlocalsMainscreenViewOutput {
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

extension MeetlocalsMainscreenPresenter: MeetlocalsMainscreenInteractorOutput {
    func didLoad(events: [Event]) {
        let viewModels = self.makeViewModels(events: events)
        self.view?.set(viewModels: viewModels)
    }
}

private extension MeetlocalsMainscreenPresenter {
    func makeViewModels(events: [Event]) -> [EventViewModel] {
        return events.map { EventViewModel(description: $0.description) }
    }
}
