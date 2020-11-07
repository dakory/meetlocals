//
//  OrganizerScreenContainer.swift
//  eventScreen
//
//  Created by Danil Ilichev on 29.10.2020.
//  
//

import UIKit

final class OrganizerScreenContainer {
    let input: OrganizerScreenModuleInput
	let viewController: UIViewController
	private(set) weak var router: OrganizerScreenRouterInput!

	static func assemble(with context: OrganizerScreenContext) -> OrganizerScreenContainer {
        let router = OrganizerScreenRouter()
        let interactor = OrganizerScreenInteractor()
        let presenter = OrganizerScreenPresenter(router: router, interactor: interactor)
		let viewController = OrganizerScreenViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return OrganizerScreenContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: OrganizerScreenModuleInput, router: OrganizerScreenRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct OrganizerScreenContext {
	weak var moduleOutput: OrganizerScreenModuleOutput?
}
