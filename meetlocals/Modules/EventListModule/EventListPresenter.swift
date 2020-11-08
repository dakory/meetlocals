//
//  EventListPresenter.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

final class EventListPresenter {
    weak var view: EventListViewInput?
    weak var moduleOutput: EventListModuleOutput?
    
    private let router: EventListRouterInput
    private let interactor: EventListInteractorInput
    
    init(router: EventListRouterInput, interactor:EventListInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventListPresenter: EventListModuleInput {
}

extension EventListPresenter: EventListViewOutput {
    func didTabEvent(meetingID: Int) {
        self.router.goToEventScreen(vc: self.view as! EventListController, meetingID: meetingID)
    }
    
    func didTabAddEvent() {
        self.router.showAddEvent()
    }
    
    
    func viewDidLoad() {
        self.interactor.fetchEvents()
    }
}

extension EventListPresenter: EventListInteractorOutput {
    func didLoad(events: [Event]) {
        let viewModels = self.makeViewModels(events: events)
        self.view?.set(viewModels: viewModels)
    }
}

private extension EventListPresenter {
    func makeViewModels(events: [Event]) -> [EventViewModel] {
        return events.map { EventViewModel(id: $0.id, idOrganizer: $0.idOrganizer, name: $0.name, description: $0.description) }
    }
}
