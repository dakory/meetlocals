//
//  FavoriteEventsPresenter.swift
//  meetlocals
//
//  Created by Danil Ilichev on 15.11.2020.
//  
//

import Foundation

final class FavoriteEventsPresenter {
	weak var view: FavoriteEventsViewInput?
    weak var moduleOutput: FavoriteEventsModuleOutput?
    
	private let router: FavoriteEventsRouterInput
	private let interactor: FavoriteEventsInteractorInput
    
    init(router: FavoriteEventsRouterInput, interactor: FavoriteEventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FavoriteEventsPresenter: FavoriteEventsModuleInput {
}

extension FavoriteEventsPresenter: FavoriteEventsViewOutput {
}

extension FavoriteEventsPresenter: FavoriteEventsInteractorOutput {
}
