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
    func didTabAddEvent()
}

protocol AddEventViewInput: class {
}

protocol AddEventViewOutput: class {
}

protocol AddEventInteractorInput: class {
}

protocol AddEventInteractorOutput: class {
}

protocol AddEventRouterInput: class {
}
