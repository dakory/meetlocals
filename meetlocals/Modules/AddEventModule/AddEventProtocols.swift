//
//  AddEventProtocols.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

protocol AddEventModuleInput {
    var moduleOutput: AddEventModuleOutput? { get }
}

protocol AddEventModuleOutput: class {
    func viewDidLoad()
}

protocol AddEventViewInput: class {
}

protocol AddEventViewOutput: class {
    func didTabAddEvent(name: String, description: String, date: Date, place: String)
}

protocol AddEventInteractorInput: class {
}

protocol AddEventInteractorOutput: class {
}

protocol AddEventRouterInput: class {
    func addEvent(name: String, description: String, date: Date, place: String)
}
