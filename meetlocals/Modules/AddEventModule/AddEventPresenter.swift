//
//  AddEventPresenter.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation
import UIKit

final class AddEventPresenter {
    weak var view: AddEventViewInput?
    weak var moduleOutput: AddEventModuleOutput?
    
    private let router: AddEventRouterInput
    private let interactor: AddEventInteractorInput
    
    init(router: AddEventRouterInput, interactor: AddEventInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AddEventPresenter: AddEventModuleInput {
}

extension AddEventPresenter: AddEventViewOutput {
    func CheckIsEmptyOrNot(text: String) -> Bool {
        let letters = CharacterSet.letters
        let numbers = CharacterSet.decimalDigits
        return text.isEmpty || (text.rangeOfCharacter(from: letters) == nil && text.rangeOfCharacter(from: numbers) == nil)
    }
    
    func didTabAddEvent(name: String, description: String, date: Date, place: String) {
        if CheckIsEmptyOrNot(text: name) || CheckIsEmptyOrNot(text: description) || CheckIsEmptyOrNot(text: place) {
            let alertController = UIAlertController(title: "Ошибка", message: "Пожалуйста, заполните все поля", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ок", style: .default)
            )
            (self.view as! AddEventViewController).present(alertController, animated: true)
            self.view?.makeButtonUserEnabled()
            return
        }
        else {
            self.interactor.addEvent(name: name, description: description, date: date, place: place)
        }
    }
}

extension AddEventPresenter: AddEventInteractorOutput {
    func reloadScreens(){
        let successfullyСreatedController = UIAlertController(title: "Успех", message: "Ваше мероприятие успешно создано", preferredStyle: .alert)
        successfullyСreatedController.addAction(UIAlertAction(title: "Ок", style: .default))
        (self.view as! AddEventViewController).present(successfullyСreatedController, animated: true)

        let listNavigationControllers  = (self.view as! AddEventViewController).tabBarController!.viewControllers![0] as! UINavigationController
        let listNavigationController = listNavigationControllers.viewControllers[0] as! EventListController
        listNavigationController.updateList()
                                
        let organizingListNavigationControllers  = (self.view as! AddEventViewController).tabBarController!.viewControllers![1] as! UINavigationController
        let organizingListNavigationController = organizingListNavigationControllers.viewControllers[0] as! EventListController
        organizingListNavigationController.updateList()
        
        let participatingListNavigationControllers  = (self.view as! AddEventViewController).tabBarController!.viewControllers![3] as! UINavigationController
        let participatingListNavigationController = participatingListNavigationControllers.viewControllers[0] as! EventListController
        participatingListNavigationController.updateList()
        
        let addEventNavigationControllers  = (self.view as! AddEventViewController).tabBarController!.viewControllers![2] as! UINavigationController
        let addEventNavigationController = addEventNavigationControllers.viewControllers[0] as! AddEventViewController

        addEventNavigationController.cleanScreen()

        (self.view as! AddEventViewController).tabBarController!.selectedIndex = 0
    }
}
