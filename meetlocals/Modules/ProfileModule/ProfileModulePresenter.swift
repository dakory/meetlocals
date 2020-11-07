//
//  ProfileModulePresenter.swift
//  ProfileModule
//
//  Created by Dmitry Koryakin on 28.10.2020.
//  
//

import Foundation

final class ProfileModulePresenter {
	weak var view: ProfileModuleViewInput?
    weak var moduleOutput: ProfileModuleModuleOutput?
    
	private let router: ProfileModuleRouterInput
	private let interactor: ProfileModuleInteractorInput
    
    init(router: ProfileModuleRouterInput, interactor: ProfileModuleInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfileModulePresenter: ProfileModuleModuleInput {
}

extension ProfileModulePresenter: ProfileModuleViewOutput {
}

extension ProfileModulePresenter: ProfileModuleInteractorOutput {
}
