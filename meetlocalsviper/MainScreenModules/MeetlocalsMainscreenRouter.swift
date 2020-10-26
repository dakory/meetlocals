//
//  MeetlocalsMainscreenRouter.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class MeetlocalsMainscreenRouter {
    var viewController: UIViewController?
}

extension MeetlocalsMainscreenRouter: MeetlocalsMainscreenRouterInput {
    func showAddEvent() {
        let alertController = UIAlertController(title: "Добавить событие", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "Добавить", style: .default)
        )
        

    viewController?.present(alertController, animated: true)
    }
    
    func showEvent() {
        let alertController = UIAlertController(title: "Показать событие", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Закрыть", style: .default))
        viewController?.present(alertController, animated: true)
    }
}


    
    

