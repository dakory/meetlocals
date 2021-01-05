//
//  LoadingModuleProtocols.swift
//  meetlocals
//
//  Created by Dmitry Koryakin on 05.01.2021.
//  
//

import UIKit

protocol LoadingModuleModuleInput {
	var moduleOutput: LoadingModuleModuleOutput? { get }
}

protocol LoadingModuleModuleOutput: class {
	var apiClient: APIClient { get }
	var window: UIWindow? { get set }
	var tabBar: UITabBarController { get }

	func setupTabBar()
}

protocol LoadingModuleViewInput: class {
}

protocol LoadingModuleViewOutput: class {
	func onLoadingView()
}

protocol LoadingModuleInteractorInput: class {
	func getData()
}

protocol LoadingModuleInteractorOutput: class {
	var moduleOutput: LoadingModuleModuleOutput? { get }

	func getDataFinished()
}

protocol LoadingModuleRouterInput: class {
	func showTabBar()
}

protocol LoadingRouterOutput: class {
	var moduleOutput: LoadingModuleModuleOutput? { get }
}