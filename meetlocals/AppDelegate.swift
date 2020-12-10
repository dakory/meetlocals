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
    
    let client = APIClient()

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        print("url: \(url)")
        print("Everything is cool!")

        let interactor = InteractorImpl()
        
        let currentVkUser = interactor.getVkCurrentUser()
        
   //      Получение events

        currentVkUser.observe(on: MainScheduler.instance)
            .subscribe(
                    onNext: { (response: VKUser) in
                        
                        self.client.getDataTask("users-by-vk-id/\(String(describing: response.id!))") { (result: Result<ProfileResponse, Error>) in             //если пользователь есть в БД
                            do {
                                let profileResponse = try result.get()
                                Common.myProfile = profileResponse.profile
                            }
                            catch {     //если пользователя нет в БД
                                let newUser = [
                                    "name": "\(response.first_name!) \(response.last_name!)",
                                    "vk_id": Int(response.id!),
                                    "avatar_url": "exampleImageOfPerson"] as [String : Any]
                                self.client.postDataTask("users", data: newUser) { (result: Result<ProfileResponse, Error>) in
                                    do {
                                        let profileResponse = try result.get()
                                        print(profileResponse.profile)
                                    }
                                    catch {
                                        print(error)
                                    }
                                    
                                    self.client.getDataTask("users/4") { (result: Result<ProfileResponse, Error>) in
                                        do {
                                            let profileResponse = try result.get()
                                            Common.myProfile = Profile(id: profileResponse.profile.id, vkId: Int(response.id!), name: "\(response.first_name!) \(response.last_name!)", sex: 0, birthDate: Date(timeIntervalSinceReferenceDate: 0), description: "", avatarUrl: "exampleImageOfPerson", idOrganizedEvents: [], idParticipateEvents: [])
                                        }
                                        catch {
                                            print(error)
                                        }
                                    }
                                }
                                print(error)
                            }
                        }

                    }, onError:
            { error in
                print(error)
            }, onCompleted:
            { print("Completed") })
        

        if (VKSdk.isLoggedIn()) {
//            Common.generateEventsData()   //подгружаем общий список мероприятий
//            Common.generateProfilesData() //подгружаем общий список пользователей
            
        //      Получение events
            client.getDataTask("events") { (result: Result<EventsResponse, Error>) in
                do {
                    let eventsResponse = try result.get()
                    Common.events = Events(listOfEvents: eventsResponse.events)
                }
                catch {
                    print(error)
                }
            }
            
       //      Получение users
            client.getDataTask("users") { (result: Result<ProfilesResponse, Error>) in
                do {
                    let profilesResponse = try result.get()
                    Common.profiles = Profiles(profiles: profilesResponse.profiles)
                }
                catch {
                    print(error)
                }
            }
            
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = UINavigationController(rootViewController: LoadViewController());
            self.appWindow = window
            window.makeKeyAndVisible()
            
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
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
