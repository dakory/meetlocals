//
// Created by Dmitry Koryakin on 05.01.2021.
//

import UIKit
import VK_ios_sdk

final class AppCoordinator: LoadingModuleModuleOutput {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    let apiClient = APIClient()
    let tabBar = UITabBarController()


    func showErrorDialog() {
        let alertDescription: AlertDialogDescription = AlertDialogDescription(title: "Ошибка",
                subtitle: "Для продолжения необходимо авторизоваться",
                positiveButtonText: "ОК",
                positiveButtonAction: { VKSdk.authorize(VkInfo.PERMISSIONS) },
                negativeButtonText: "Закрыть приложение",
                negativeButtonAction: { exit(0) }
        )

        let alertDialogDelegate = AlertDialogDelegate(alertDescription: alertDescription)
        let controller = self.window?.rootViewController
        alertDialogDelegate.show(viewController: controller)
    }

    func openWelcomeScreen() {
        self.window?.rootViewController = UINavigationController(rootViewController:
        MainViewController())
        self.window?.makeKeyAndVisible()
    }

    func onLoginSuccess() {
        let context = LoadingModuleContext(moduleOutput: self)
        let container = LoadingModuleContainer.assemble(with: context)
        self.window?.rootViewController = container.viewController
        self.window?.makeKeyAndVisible()
    }

    func setupTabBar() {

        let organizingListContext = EventListContext(moduleOutput: self, typeOfScreen: .organizing)
        let organizingListContainer = EventListContainer.assemble(with: organizingListContext)
        let organizingListNavigationController = UINavigationController(rootViewController: organizingListContainer.viewController)

        let participatingListContext = EventListContext(moduleOutput: self, typeOfScreen:
        .participating)
        let participatingListContainer = EventListContainer.assemble(with: participatingListContext)
        let participatingListNavigationController = UINavigationController(rootViewController: participatingListContainer.viewController)

        let addEventContext = AddEventContext(moduleOutput: self)
        let addEventContainer = AddEventContainer.assemble(with: addEventContext)
        let addEventNavigationController = UINavigationController(rootViewController: addEventContainer.viewController)

        let profileModuleContext = ProfileModuleContext(moduleOutput: self, personID: Common
                .myProfile.id)
        let profileModuleContainer = ProfileModuleContainer.assemble(with: profileModuleContext)
        let profileModuleNavigationController = UINavigationController(rootViewController: profileModuleContainer.viewController)
        
        let eventListContext = EventListContext(moduleOutput: self, typeOfScreen: .common)
        let eventListContainer = EventListContainer.assemble(with: eventListContext)
        let eventListNavigationController = UINavigationController(rootViewController: eventListContainer.viewController)


        eventListContainer.viewController.loadViewIfNeeded()
        organizingListContainer.viewController.loadViewIfNeeded()
        participatingListContainer.viewController.loadViewIfNeeded()
        addEventContainer.viewController.loadViewIfNeeded()
        profileModuleContainer.viewController.loadViewIfNeeded()



        self.tabBar.setViewControllers([eventListNavigationController,
                                 organizingListNavigationController, addEventNavigationController, participatingListNavigationController, profileModuleNavigationController], animated: true)
    }
}
