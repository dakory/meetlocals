//
//  OrganizerScreenProtocols.swift
//  eventScreen
//
//  Created by Danil Ilichev on 29.10.2020.
//  
//

import Foundation

protocol OrganizerScreenModuleInput {
	var moduleOutput: OrganizerScreenModuleOutput? { get }
}

protocol OrganizerScreenModuleOutput: class {
}

protocol OrganizerScreenViewInput: class {
    func setOrganizerData(person: Profile)
}

protocol OrganizerScreenViewOutput: class {
    func getData()
    func didTapButtonOpenVK()
}

protocol OrganizerScreenInteractorInput: class {
}

protocol OrganizerScreenInteractorOutput: class {
}

protocol OrganizerScreenRouterInput: class {
}
