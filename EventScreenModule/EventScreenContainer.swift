import UIKit

final class EventScreenContainer {
    let input: EventScreenModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventScreenRouterInput!

	static func assemble(with context: EventScreenContext) -> EventScreenContainer {
        let router = EventScreenRouter()
        let interactor = EventScreenInteractor()
        let presenter = EventScreenPresenter(router: router, interactor: interactor)
		let viewController = EventScreenViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return EventScreenContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EventScreenModuleInput, router: EventScreenRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EventScreenContext {
	weak var moduleOutput: EventScreenModuleOutput?
}
