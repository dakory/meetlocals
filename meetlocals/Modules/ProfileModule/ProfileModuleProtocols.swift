//
//  ProfileModuleProtocols.swift
//  ProfileModule
//
//  Created by Dmitry Koryakin on 28.10.2020.
//  
//

import Foundation

protocol ProfileModuleModuleInput {
	var moduleOutput: ProfileModuleModuleOutput? { get }
}

protocol ProfileModuleModuleOutput: class {
}

protocol ProfileModuleViewInput: class {
}

protocol ProfileModuleViewOutput: class {
}

protocol ProfileModuleInteractorInput: class {
}

protocol ProfileModuleInteractorOutput: class {
}

protocol ProfileModuleRouterInput: class {
}
