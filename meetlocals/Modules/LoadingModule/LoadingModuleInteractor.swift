//
//  LoadingModuleInteractor.swift
//  meetlocals
//
//  Created by Dmitry Koryakin on 05.01.2021.
//  
//

import Foundation
import VK_ios_sdk
import RxSwift

final class LoadingModuleInteractor {
	weak var output: LoadingModuleInteractorOutput?
}

extension LoadingModuleInteractor: LoadingModuleInteractorInput {
	func getData() {

		let dispatchGroup = DispatchGroup()

		dispatchGroup.enter()
		let interactor = InteractorImpl()
		let currentVkUser = interactor.getVkCurrentUser()

		currentVkUser.observe(on: MainScheduler.instance)
				.subscribe(
						onNext: { (response: VKUser) in
							let avatarUrl = response.photo_200?.dropFirst().dropFirst().dropLast()
							let newUser: [String : Any] = [
								"name": "\(response.first_name!) \(response.last_name!)",
								"vk_id": Int(truncating: response.id!),
								"avatar_url": avatarUrl ?? "exampleImageOfPerson"
							]
//							print("newUser avatar: \(response.photo_200.dropLast())")
//							print("newUser avatar: \(newUser["avatar_url"]!)")
//							self.output?.moduleOutput?.apiClient.authorization(user: newUser)
							guard let vk_user_id = newUser["vk_id"] else {
								print("Error: user[vk_id] is nil")
								return
							}

							self.output?.moduleOutput?.apiClient.getDataTask("users-by-vk-id/\(vk_user_id)") {
								(result: Result<ProfileResponse, Error>) in             //если пользователь есть в БД
								do {
									let profileResponse = try result.get()
									Common.myProfile = profileResponse.profile
									dispatchGroup.leave()
								}
								catch {     //если пользователя нет в БД
									self.output?.moduleOutput?.apiClient.postDataTask("users", data: newUser) { (result:
											Result<ProfileResponse, Error>) in
										do {
											let profileResponse = try result.get()
											Common.myProfile = profileResponse.profile
											dispatchGroup.leave()
										}
										catch {
											print(error)
										}
									}
									print(error)
								}
							}
						},
						onError: { error in
							print(error)
						},
						onCompleted: {
							print("Completed")
						})


		dispatchGroup.enter()
		self.output?.moduleOutput?.apiClient.getDataTask("users") { (result: Result<ProfilesResponse, Error>) in
			do {
				let profilesResponse = try result.get()
				Common.profiles = Profiles(profiles: profilesResponse.profiles)
				dispatchGroup.leave()
			}
			catch {
				print(error)
			}
		}

		dispatchGroup.enter()
		self.output?.moduleOutput?.apiClient.getDataTask("events") { (result: Result<EventsResponse, Error>) in
			do {
				let eventsResponse = try result.get()
				Common.events = Events(listOfEvents: eventsResponse.events)
				dispatchGroup.leave()
			}
			catch {
				print(error)
			}
		}

		dispatchGroup.notify(queue: .main) {
			self.output?.getDataFinished()
		}

	}
}
