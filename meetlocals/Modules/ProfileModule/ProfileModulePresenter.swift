//
//  ProfileModulePresenter.swift
//  ProfileModule
//
//  Created by Dmitry Koryakin on 28.10.2020.
//  
//

import Foundation

final class ProfileModulePresenter {
    var personId: Int?
    
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
    func didTapButtonExit() {
        self.router.exit()
    }
    
    func getData(){
//        let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id ==  personId})
//        let person = Common.profiles.profiles[indexPerson!]
        self.view?.setProfileData(person: Common.myProfile)
    }
}

extension ProfileModulePresenter: ProfileModuleInteractorOutput {
}
