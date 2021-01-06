
import Foundation

protocol EventScreenModuleInput {
	var moduleOutput: EventScreenModuleOutput? { get }
}

protocol EventScreenModuleOutput: class {
}

protocol EventScreenViewInput: class {
    func setEventAndOrganizerData(_ person: Profile, _ event: Event)
    func setButton(_: Bool)
    func reloadMembers()
}

protocol EventScreenViewOutput: class {
    func checkMembershipPresenter()
    func getData()
    func singUpForEvent()
    func goToOrganizerScreen()
    func goToVkPresenter(toOrganizer: Bool, id: Int?)
    func checkCurrentUserIsOrganizer() -> Bool
    func DidTabDeleteEvent()
}

protocol EventScreenInteractorInput: class {
    func getInfoOfEvent(eventId: Int) -> Event
    func addOrDeleteDataNewMember(eventId: Int)
    func getInfoOrganizer(id: Int) -> Profile
    func checkMembershipData(eventId: Int) -> Bool
    func deleteEvent(eventId: Int)
}

protocol EventScreenInteractorOutput: class {
    func checkMembership()
}

protocol EventScreenRouterInput: class {
    func organizerScreen(vc: EventScreenViewController, organizerID: Int)
    func goToVk(id: Int)
    func updateScreens(vc: EventScreenViewController)
    func deleteEvent(eventId: Int)

}
