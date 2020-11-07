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
    func setOrganizerData()
}

protocol OrganizerScreenModuleOutput: class {
}

protocol OrganizerScreenViewInput: class {
}

protocol OrganizerScreenViewOutput: class {
    func getData()
}

protocol OrganizerScreenInteractorInput: class {
}

protocol OrganizerScreenInteractorOutput: class {
}

protocol OrganizerScreenRouterInput: class {
    func sendPersonToOrganizerScreen(per: Person)
}
