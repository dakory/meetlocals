
import Foundation

protocol EventScreenModuleInput {
	var moduleOutput: EventScreenModuleOutput? { get }
    func sendEventAndOrganizerData(_ person: Profile, _ event: Event)
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
    func getInfoOfEvent() -> Event
    func getInfoOrganizer(id: Int) -> Profile
}

protocol EventScreenInteractorOutput: class {
}

protocol EventScreenRouterInput: class {
    func organizerScreen(vc: EventScreenViewController, organizerID: Int)
}
