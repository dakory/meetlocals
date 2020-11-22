//
//  FavoriteEventsContainer.swift
//  meetlocals
//
//  Created by Danil Ilichev on 15.11.2020.
//  
//

import UIKit

final class FavoriteEventsContainer {
    let input: FavoriteEventsModuleInput
	let viewController: UIViewController
	private(set) weak var router: FavoriteEventsRouterInput!

	static func assemble(with context: FavoriteEventsContext) -> FavoriteEventsContainer {
        let router = FavoriteEventsRouter()
        let interactor = FavoriteEventsInteractor()
        let presenter = FavoriteEventsPresenter(router: router, interactor: interactor)
		let viewController = FavoriteEventsViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return FavoriteEventsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: FavoriteEventsModuleInput, router: FavoriteEventsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct FavoriteEventsContext {
	weak var moduleOutput: FavoriteEventsModuleOutput?
}
