
import Foundation

protocol EventScreenModuleInput {
	var moduleOutput: EventScreenModuleOutput? { get }
}

protocol EventScreenModuleOutput: class {
}

protocol EventScreenViewInput: class {
    func setEventAndOrganizerData(_ person: Profile, _ event: Event)
    func setButtonOn()
    func setButtonOff()

}

protocol EventScreenViewOutput: class {
    func checkMembership()
    func getData()
    func singUpForEvent()
    func goToOrganizerScreen()
}

protocol EventScreenInteractorInput: class {
    func getInfoOfEvent(eventId: Int) -> Event
    func addDataNewMember(eventId: Int)
    func getInfoOrganizer(id: Int) -> Profile
    func checkMembershipData(eventId: Int) -> Bool
}

protocol EventScreenInteractorOutput: class {
}

protocol EventScreenRouterInput: class {
    func organizerScreen(vc: EventScreenViewController, organizerID: Int)
}
