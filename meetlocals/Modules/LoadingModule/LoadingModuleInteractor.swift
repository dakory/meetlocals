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
		self.output?.moduleOutput?.apiClient.getCurrentUser() {
			dispatchGroup.leave()
		}

		dispatchGroup.enter()
		self.output?.moduleOutput?.apiClient.getUsers() {
			dispatchGroup.leave()
		}

		dispatchGroup.enter()
		self.output?.moduleOutput?.apiClient.getEvents() {
			dispatchGroup.leave()
		}

		dispatchGroup.notify(queue: .main) {
			self.output?.getDataFinished()
		}

	}
}
