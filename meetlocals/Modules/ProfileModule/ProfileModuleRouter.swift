//
//  ProfileModuleRouter.swift
//  ProfileModule
//
//  Created by Dmitry Koryakin on 28.10.2020.
//  
//

import UIKit

final class ProfileModuleRouter {
    var viewController: UIViewController?
}

extension ProfileModuleRouter: ProfileModuleRouterInput {
    func exit() {
        let alertController = UIAlertController(title: "", message: "Тут должен быть выход", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: .default)
        )
        self.viewController?.present(alertController, animated: true)
        return
    }
}
