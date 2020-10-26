//
//  MeetlocalsContainer.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class MeetlocalsMainscreenContainer {
    let input: MeetlocalsMainscreenModuleInput
    let viewController: UIViewController
    
    private(set) weak var router: MeetlocalsMainscreenRouterInput!

    static func assemble(with context: MeetlocalsMainscreenContext) -> MeetlocalsMainscreenContainer {
        let router = MeetlocalsMainscreenRouter()
        let interactor = MeetlocalsMainscreenInteractor()
        let presenter = MeetlocalsMainscreenPresenter(router: router, interactor: interactor)
        let viewController = MeetlocalsMainscreenController(output: presenter)

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        router.viewController = viewController
        interactor.output = presenter

        return MeetlocalsMainscreenContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController, input: MeetlocalsMainscreenModuleInput, router: MeetlocalsMainscreenRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct MeetlocalsMainscreenContext {
    weak var moduleOutput: MeetlocalsMainscreenModuleOutput?
}
