//
//  OrganizerScreenPresenter.swift
//  eventScreen
//
//  Created by Danil Ilichev on 29.10.2020.
//  
//

import Foundation

var organizer = Person(name: "", imagePerson: "")

final class OrganizerScreenPresenter {
	weak var view: OrganizerScreenViewInput?
    weak var moduleOutput: OrganizerScreenModuleOutput?
    
	private let router: OrganizerScreenRouterInput
	private let interactor: OrganizerScreenInteractorInput
    
    init(router: OrganizerScreenRouterInput, interactor: OrganizerScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension OrganizerScreenPresenter: OrganizerScreenModuleInput {
    func setOrganizerData(){
        (self.view as! OrganizerScreenViewController).nameOfPerson.text = organizer.name
        (self.view as! OrganizerScreenViewController).imageOfPerson.image =  organizer.imagePersonString

    }
}

extension OrganizerScreenPresenter: OrganizerScreenViewOutput {
    func getData(){
        setOrganizerData()
    }
}

extension OrganizerScreenPresenter: OrganizerScreenInteractorOutput {
}
