//
//  AddEventProtocols.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

protocol AddEventModuleInput {
    var moduleOutput: AddEventModuleOutput? { get }
}

protocol AddEventModuleOutput: class {
//    func viewDidLoad()
    var tabBar: UITabBarController { get set }
}

protocol AddEventViewInput: class {
    func cleanScreen()
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
