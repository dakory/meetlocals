//
// Created by 17099611 on 04.01.2021.
//

import Foundation
import VK_ios_sdk

class VkAuthorizer {

    private var vkDelegate: VKSdkDelegate?
    private var vkUiDelegate: VKSdkUIDelegate?

    deinit {
        clearDelegates()
    }

    public func userWasAuthorized() -> Bool {
        VKSdk.processOpen(VkInfo.VK_AUTHORIZATION_URL, fromApplication: VkInfo.APPLICATION_ID)
        initVkDelegates()
        VKSdk.wakeUpSession(VkInfo.PERMISSIONS, complete: signedIn)

        return VKSdk.isLoggedIn()
    }

    @objc
    public func authorize() {
        let vkUrl = VkInfo.VK_AUTHORIZATION_URL
        print(vkUrl)
        VKSdk.processOpen(vkUrl, fromApplication: VkInfo.APPLICATION_ID)
        self.initVkDelegates()
        VKSdk.wakeUpSession(VkInfo.PERMISSIONS, complete: signedIn)
        VKSdk.authorize(VkInfo.PERMISSIONS)
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

            //TODO открыть EventListModule
        } else if (state == VKAuthorizationState.error) {
            print("Some error happened")
        }
    }
}
