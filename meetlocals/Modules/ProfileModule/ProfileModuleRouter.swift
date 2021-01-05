//
//  ProfileModuleRouter.swift
//  ProfileModule
//
//  Created by Dmitry Koryakin on 28.10.2020.
//  
//

import UIKit
import VK_ios_sdk

final class ProfileModuleRouter {
    var viewController: UIViewController?
}

extension ProfileModuleRouter: ProfileModuleRouterInput {
    func exit() {
        let alertController = UIAlertController(title: "Выход", message: "Вы уверены что хотите выйти?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Да", style: .default) { action in
            VKSdk.forceLogout()
            self.openWelcomeScreen()
        })
        alertController.addAction(UIAlertAction(title: "Нет", style: .default))
        self.viewController?.present(alertController, animated: true)
    }

    private func openWelcomeScreen() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: MainViewController())
        (UIApplication.shared.delegate as! AppDelegate).coordinator.window = window
        window.makeKeyAndVisible()
    }
}
