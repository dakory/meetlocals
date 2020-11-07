//
//  ProfileModuleInteractor.swift
//  ProfileModule
//
//  Created by Dmitry Koryakin on 28.10.2020.
//  
//

import Foundation

final class ProfileModuleInteractor {
	weak var output: ProfileModuleInteractorOutput?
}

extension ProfileModuleInteractor: ProfileModuleInteractorInput {
}
