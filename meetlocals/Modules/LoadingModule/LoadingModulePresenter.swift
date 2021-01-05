//
//  LoadingModulePresenter.swift
//  meetlocals
//
//  Created by Dmitry Koryakin on 05.01.2021.
//  
//

import Foundation

final class LoadingModulePresenter {
	weak var view: LoadingModuleViewInput?
    weak var moduleOutput: LoadingModuleModuleOutput?
    
	private let router: LoadingModuleRouterInput
	private let interactor: LoadingModuleInteractorInput
    
    init(router: LoadingModuleRouterInput, interactor: LoadingModuleInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LoadingModulePresenter: LoadingModuleModuleInput {
}

extension LoadingModulePresenter: LoadingModuleViewOutput {
    func onLoadingView() {
        interactor.getData()
    }
}

extension LoadingModulePresenter: LoadingModuleInteractorOutput {
    func getDataFinished() {
        router.showTabBar()
    }
}

extension LoadingModulePresenter: LoadingRouterOutput {
}