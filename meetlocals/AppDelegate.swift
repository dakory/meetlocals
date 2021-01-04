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

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    let apiClient = APIClient()
    let vkAuthorizer = VkAuthorizer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if (vkAuthorizer.userWasAuthorized()) {
            openMainScreen()
        } else {
            openWelcomeScreen()
        }

        return true
    }



    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        print("url: \(url)")
        print("Everything is cool!")

        let interactor = InteractorImpl()

        let currentVkUser = interactor.getVkCurrentUser()

        currentVkUser.observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { (response: VKUser) in
                    let newUser: [String : Any] = [
                        "name": "\(response.first_name!) \(response.last_name!)",
                        "vk_id": Int(truncating: response.id!),
                        "avatar_url": response.photo_200 ?? "exampleImageOfPerson"
                    ]

                    self.apiClient.authorization(user: newUser)
                },
                onError: { error in
                    print(error)
                },
                onCompleted: {
                    print("Completed")
                })
        

        if (VKSdk.isLoggedIn()) {
            openMainScreen()
            return true
        } else {
            showErrorDialog()
            return true
        }
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
        let controller = self.window?.rootViewController
        alertDialogDelegate.show(viewController: controller)
    }


    private func openWelcomeScreen() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: MainViewController())
        self.window = window
        window.makeKeyAndVisible()
    }

    private func openMainScreen() {
        apiClient.getUsers() //подгружаем общий список пользователей
        apiClient.getEvents() //подгружаем общий список мероприятий


        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: LoadViewController());
        self.window = window
        window.makeKeyAndVisible()

        Timer.scheduledTimer(withTimeInterval: 20, repeats: false) { (_) in // после
            // трёхсекундной задержки отображаем список мероприятий
            let appWindow = UIWindow(frame: UIScreen.main.bounds)
            self.window = appWindow

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

            let profileModuleContext = ProfileModuleContext(moduleOutput: nil, personID: Common.myProfile.id)
            let profileModuleContainer = ProfileModuleContainer.assemble(with: profileModuleContext)
            let profileModuleNavigationController = UINavigationController(rootViewController: profileModuleContainer.viewController)
            let tabBar = UITabBarController()

            eventListContainer.viewController.loadViewIfNeeded()
            organizingListContainer.viewController.loadViewIfNeeded()
            participatingListContainer.viewController.loadViewIfNeeded()
            addEventContainer.viewController.loadViewIfNeeded()
            profileModuleContainer.viewController.loadViewIfNeeded()


            organizingListNavigationController.navigationBar.prefersLargeTitles = true
            participatingListNavigationController.navigationBar.prefersLargeTitles = true


            tabBar.setViewControllers([eventListNavigationController, organizingListNavigationController, participatingListNavigationController, addEventNavigationController, profileModuleNavigationController], animated: true)

            appWindow.rootViewController = tabBar
            appWindow.makeKeyAndVisible()
        }
    }
}

