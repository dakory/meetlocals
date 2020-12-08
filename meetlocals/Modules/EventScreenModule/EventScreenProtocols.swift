
import Foundation

protocol EventScreenModuleInput {
	var moduleOutput: EventScreenModuleOutput? { get }
}

protocol EventScreenModuleOutput: class {
}

protocol EventScreenViewInput: class {
    func setEventAndOrganizerData(_ person: Profile, _ event: Event)
    func setButton(_: Bool)

}

protocol EventScreenViewOutput: class {
    func checkMembership()
    func getData()
    func singUpForEvent()
    func goToOrganizerScreen()
    func goToVkPresenter(toOrganizer: Bool, id: Int?)
}

protocol EventScreenInteractorInput: class {
    func getInfoOfEvent(eventId: Int) -> Event
    func addOrDeleteDataNewMember(eventId: Int)
    func getInfoOrganizer(id: Int) -> Profile
    func checkMembershipData(eventId: Int) -> Bool
}

protocol EventScreenInteractorOutput: class {
}

protocol EventScreenRouterInput: class {
    func organizerScreen(vc: EventScreenViewController, organizerID: Int)
    func goToVk(id: Int)
    func updateScreens(vc: EventScreenViewController)

}
