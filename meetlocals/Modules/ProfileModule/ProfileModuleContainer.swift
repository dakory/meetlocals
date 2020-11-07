//
//  ProfileModuleContainer.swift
//  ProfileModule
//
//  Created by Dmitry Koryakin on 28.10.2020.
//  
//

import UIKit

final class ProfileModuleContainer {
    let input: ProfileModuleModuleInput
	let viewController: UIViewController
	private(set) weak var router: ProfileModuleRouterInput!

	static func assemble(with context: ProfileModuleContext) -> ProfileModuleContainer {
        let router = ProfileModuleRouter()
        let interactor = ProfileModuleInteractor()
        let presenter = ProfileModulePresenter(router: router, interactor: interactor)
		let viewController = ProfileModuleViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return ProfileModuleContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ProfileModuleModuleInput, router: ProfileModuleRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ProfileModuleContext {
	weak var moduleOutput: ProfileModuleModuleOutput?
}
