
import Foundation

protocol EventScreenModuleInput {
	var moduleOutput: EventScreenModuleOutput? { get }
    func sendOrganizerData(data: Person)
}

protocol EventScreenModuleOutput: class {
}

protocol EventScreenViewInput: class {

}

protocol EventScreenViewOutput: class {
    func getData()
    func singUpForEvent()
    func goToOrganizerScreen()
}

protocol EventScreenInteractorInput: class {
    func getListOfPeople() -> [Person]
}

protocol EventScreenInteractorOutput: class {
}

protocol EventScreenRouterInput: class {
    func organizerScreen(vc: EventScreenViewController, organizer: Person)
}
