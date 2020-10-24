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

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        print("url: \(url)")
        print("Everything is cool!")
        //TODO открыть другой экран
        return true
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
            print("User already has been authrized")
            print("Everything is cool!")
            //TODO открыть другой экран
        } else if (state == VKAuthorizationState.error) {
            print("Some error happened")
        }
    }
}
