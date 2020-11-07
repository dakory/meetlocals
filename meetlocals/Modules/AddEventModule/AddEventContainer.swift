//
//  AddEventContainer.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class AddEventContainer {
    let input: AddEventModuleInput
    let viewController: UIViewController
    private(set) weak var router: AddEventRouterInput!

    static func assemble(with context: AddEventContext) -> AddEventContainer {
        let router = AddEventRouter()
        let interactor = AddEventInteractor()
        let presenter = AddEventPresenter(router: router, interactor: interactor)
        let viewController = AddEventViewController(output: presenter)

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput

        interactor.output = presenter
        router.viewController = viewController

        return AddEventContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController, input: AddEventModuleInput, router: AddEventRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct AddEventContext {
    weak var moduleOutput: AddEventModuleOutput?
}
