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

    let coordinator = AppCoordinator()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if (VkAuthorizer().userWasAuthorized()) {
            coordinator.onLoginSuccess()
        } else {
            coordinator.openWelcomeScreen()
        }

        return true
    }


    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {

        VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        print("url: \(url)")
        print("Everything is cool!")

        if (VKSdk.isLoggedIn()) {
            coordinator.onLoginSuccess()
        } else {
            coordinator.showErrorDialog()
        }

        return true
    }


    private func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        VKSdk.processOpen(url as URL?, fromApplication: sourceApplication)
        print("url: \(url)")
        return true
    }
}

