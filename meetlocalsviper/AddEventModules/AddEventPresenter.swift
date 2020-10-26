//
//  AddEventPresenter.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

final class AddEventPresenter {
    weak var view: AddEventViewInput?
    weak var moduleOutput: AddEventModuleOutput?
    
    private let router: AddEventRouterInput
    private let interactor: AddEventInteractorInput
    
    init(router: AddEventRouterInput, interactor: AddEventInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AddEventPresenter: AddEventModuleInput {
}

extension AddEventPresenter: AddEventViewOutput {
}

extension AddEventPresenter: AddEventInteractorOutput {
}
