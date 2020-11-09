
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
    func checkMembership()
    func getData()
    func singUpForEvent()
    func goToOrganizerScreen()
}

protocol EventScreenInteractorInput: class {
    func getInfoOfEvent() -> Event
    func addDataNewMember(eventId: Int)
    func getInfoOrganizer(id: Int) -> Profile
    func checkMembershipData(eventId: Int) -> Bool
}

protocol EventScreenInteractorOutput: class {
}

protocol EventScreenRouterInput: class {
    func sendToEventsScreen(id: Int)
    func organizerScreen(vc: EventScreenViewController, organizerID: Int)
}
