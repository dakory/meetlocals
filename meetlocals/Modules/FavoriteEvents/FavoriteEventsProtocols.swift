//
//  FavoriteEventsProtocols.swift
//  meetlocals
//
//  Created by Danil Ilichev on 15.11.2020.
//  
//

import Foundation

protocol FavoriteEventsModuleInput {
	var moduleOutput: FavoriteEventsModuleOutput? { get }
}

protocol FavoriteEventsModuleOutput: class {
}

protocol FavoriteEventsViewInput: class {
}

protocol FavoriteEventsViewOutput: class {
}

protocol FavoriteEventsInteractorInput: class {
}

protocol FavoriteEventsInteractorOutput: class {
}

protocol FavoriteEventsRouterInput: class {
}
