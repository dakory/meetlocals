//
//  LoadingModuleContainer.swift
//  meetlocals
//
//  Created by Dmitry Koryakin on 05.01.2021.
//  
//

import UIKit

final class LoadingModuleContainer {
    let input: LoadingModuleModuleInput
	let viewController: UIViewController
	private(set) weak var router: LoadingModuleRouterInput!

	static func assemble(with context: LoadingModuleContext) -> LoadingModuleContainer {
        let router = LoadingModuleRouter()
        let interactor = LoadingModuleInteractor()
        let presenter = LoadingModulePresenter(router: router, interactor: interactor)
		let viewController = LoadingModuleViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

		router.output = presenter

        return LoadingModuleContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: LoadingModuleModuleInput, router: LoadingModuleRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct LoadingModuleContext {
	weak var moduleOutput: LoadingModuleModuleOutput?

	init(moduleOutput: LoadingModuleModuleOutput) {
		self.moduleOutput = moduleOutput
	}
}
