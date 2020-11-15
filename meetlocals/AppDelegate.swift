//
//  AppDelegate.swift
//  meetlocals
//
//  Created by Dmitry Koryakin on 14.10.2020.
//
//

import UIKit
import VK_ios_sdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appWindow: UIWindow?
    var vkDelegate: VKSdkDelegate?
    var vkUiDelegate: VKSdkUIDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        vkAuthorization()
        clearDelegates()
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
            
            let eventListContext = EventListContext(moduleOutput: nil)
            let eventListContainer = EventListContainer.assemble(with: eventListContext)
            let eventListNavigationController = UINavigationController(rootViewController: eventListContainer.viewController)
            
            let favoriteEventsContext = FavoriteEventsContext(moduleOutput: nil)
            let favoriteEventsContainer = FavoriteEventsContainer.assemble(with: favoriteEventsContext)
            let favoriteEventsNavigationController = UINavigationController(rootViewController: favoriteEventsContainer.viewController)
            
            let addEventContext = AddEventContext(moduleOutput: nil)
            let addEventContainer = AddEventContainer.assemble(with: addEventContext)
            let addEventNavigationController = UINavigationController(rootViewController: addEventContainer.viewController)
            
            let organizerScreenContext = OrganizerScreenContext(moduleOutput: nil, personID: Common.myProfile.id)
            let organizerScreenContainer = OrganizerScreenContainer.assemble(with: organizerScreenContext)
            let organizerScreeNavigationController = UINavigationController(rootViewController: organizerScreenContainer.viewController)
        
            let tabBar = UITabBarController()
            
            favoriteEventsContainer.viewController.loadViewIfNeeded()
            addEventContainer.viewController.loadViewIfNeeded()
            organizerScreenContainer.viewController.loadViewIfNeeded()

            tabBar.setViewControllers([eventListNavigationController,favoriteEventsNavigationController, addEventNavigationController, organizerScreeNavigationController], animated: true)
            
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

    private func vkAuthorization() {
        let vkUrl = VkInfo.VK_AUTHORIZATION_URL
        print(vkUrl)
        VKSdk.processOpen(vkUrl, fromApplication: VkInfo.APPLICATION_ID)
        initVkDelegates()
        VKSdk.wakeUpSession(VkInfo.PERMISSIONS, complete: signedIn)
        VKSdk.authorize(VkInfo.PERMISSIONS)
        print("authorize")
    }

    private func initVkDelegates() {
        vkDelegate = VkDelegate()
        vkUiDelegate = VkUiDelegate()
        let sdkInstance = VKSdk.initialize(withAppId: VkInfo.APPLICATION_ID)
        sdkInstance?.register(vkDelegate)
        sdkInstance?.uiDelegate = vkUiDelegate
    }

    private func clearDelegates() {
        vkDelegate = nil
        vkUiDelegate = nil
    }

    private func signedIn(state: VKAuthorizationState, error: Error!) {
        if (state == VKAuthorizationState.authorized) {

            print("User already has been authorized")
            print("Everything is cool!")

            let interactor = InteractorImpl()
            interactor.getUser()
                    .subscribe(
                            onNext: { (response: VKUser) in
                                print(response)
                            }, onError:
                    { error in
                        print(error)
                    }, onCompleted:
                    { print("Completed") })

//            Common.generateEventsData()   //подгружаем общий список мероприятий
//            Common.generateProfilesData() //подгружаем общий список пользователей
//            let context = EventListContext(moduleOutput: nil)
//            let container = EventListContainer.assemble(with: context)
//            let appWindow = UIWindow(frame: UIScreen.main.bounds)
//            self.appWindow = appWindow
//            let navigationController = UINavigationController(rootViewController: container.viewController)
//            appWindow.rootViewController = navigationController
//            appWindow.makeKeyAndVisible()

            //TODO открыть EventListModule
        } else if (state == VKAuthorizationState.error) {
            print("Some error happened")
        }
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
}
