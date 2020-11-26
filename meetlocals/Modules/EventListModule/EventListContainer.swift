//
//  EventListContainer.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class EventListContainer {
    let input: EventListModuleInput
    let viewController: UIViewController
    
    private(set) weak var router: EventListRouterInput!

    static func assemble(with context: EventListContext) -> EventListContainer {
        let router = EventListRouter()
        let interactor = EventListInteractor()
        let presenter = EventListPresenter(router: router, interactor: interactor)
        let viewController = EventListController(output: presenter)
        
        presenter.typeOfScreen = context.typeOfScreen

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        router.viewController = viewController
        interactor.output = presenter

        return EventListContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController, input: EventListModuleInput, router: EventListRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct EventListContext {
    weak var moduleOutput: EventListModuleOutput?
    let typeOfScreen: TypeOfListScreen?
}
