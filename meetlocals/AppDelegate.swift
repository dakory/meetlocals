//
//  AppDelegate.swift
//  meetlocals
//
//  Created by Dmitry Koryakin on 14.10.2020.
//
//

import UIKit
import VK_ios_sdk
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appWindow: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        openWelcomeScreen()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        print("url: \(url)")
        print("Everything is cool!")

        if (VKSdk.isLoggedIn()) {
            Common.generateEventsData()   //подгружаем общий список мероприятий
            Common.generateProfilesData() //подгружаем общий список пользователей

            let appWindow = UIWindow(frame: UIScreen.main.bounds)
            self.appWindow = appWindow

            let eventListContext = EventListContext(moduleOutput: nil, typeOfScreen: .common)
            let eventListContainer = EventListContainer.assemble(with: eventListContext)
            let eventListNavigationController = UINavigationController(rootViewController: eventListContainer.viewController)

            let organizingListContext = EventListContext(moduleOutput: nil, typeOfScreen: .organizing)
            let organizingListContainer = EventListContainer.assemble(with: organizingListContext)
            let organizingListNavigationController = UINavigationController(rootViewController: organizingListContainer.viewController)

            let participatingListContext = EventListContext(moduleOutput: nil, typeOfScreen: .participating)
            let participatingListContainer = EventListContainer.assemble(with: participatingListContext)
            let participatingListNavigationController = UINavigationController(rootViewController: participatingListContainer.viewController)

            let addEventContext = AddEventContext(moduleOutput: nil)
            let addEventContainer = AddEventContainer.assemble(with: addEventContext)
            let addEventNavigationController = UINavigationController(rootViewController: addEventContainer.viewController)

//            let organizerScreenContext = OrganizerScreenContext(moduleOutput: nil, personID: Common.myProfile.id)
//            let organizerScreenContainer = OrganizerScreenContainer.assemble(with: organizerScreenContext)
//            let organizerScreeNavigationController = UINavigationController(rootViewController: organizerScreenContainer.viewController)

            let profileModuleContext = ProfileModuleContext(moduleOutput: nil, personID: Common.myProfile.id)
            let profileModuleContainer = ProfileModuleContainer.assemble(with: profileModuleContext)
            let profileModuleNavigationController = UINavigationController(rootViewController: profileModuleContainer.viewController)
            let tabBar = UITabBarController()

            eventListContainer.viewController.loadViewIfNeeded()
            organizingListContainer.viewController.loadViewIfNeeded()
            participatingListContainer.viewController.loadViewIfNeeded()
            addEventContainer.viewController.loadViewIfNeeded()
            profileModuleContainer.viewController.loadViewIfNeeded()

            tabBar.setViewControllers([eventListNavigationController, organizingListNavigationController, participatingListNavigationController, addEventNavigationController, profileModuleNavigationController], animated: true)

            appWindow.rootViewController = tabBar
            appWindow.makeKeyAndVisible()

            return true
        } else {
            showErrorDialog()
            return true
        }
        //TODO открыть другой экран -- Какой?
    }

    private func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        VKSdk.processOpen(url as URL?, fromApplication: sourceApplication)
        print("url: \(url)")
        return true
    }

    private func showErrorDialog() {
        let alertDescription: AlertDialogDescription = AlertDialogDescription(title: "Ошибка",
                subtitle: "Для продолжения необходимо авторизоваться",
                positiveButtonText: "ОК",
                positiveButtonAction: { VKSdk.authorize(VkInfo.PERMISSIONS) },
                negativeButtonText: "Закрыть приложение",
                negativeButtonAction: { exit(0) }
        )

        let alertDialogDelegate = AlertDialogDelegate(alertDescription: alertDescription)
        let controller = self.appWindow?.rootViewController
        alertDialogDelegate.show(viewController: controller)
    }

    private func openWelcomeScreen() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: MainViewController())
        self.appWindow = window
        window.makeKeyAndVisible()
    }
}
