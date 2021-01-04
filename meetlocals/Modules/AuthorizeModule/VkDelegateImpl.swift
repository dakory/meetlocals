//
// Created by AkhIgor on 20.10.2020.
//

import Foundation
import VK_ios_sdk

class VkDelegateImpl: NSObject, VKSdkDelegate,VKSdkUIDelegate {

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        let window = UIWindow()
        window.rootViewController = controller
        window.makeKeyAndVisible()
        (UIApplication.shared.delegate as! AppDelegate).window = window
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("vkSdkNeedCaptchaEnter(_ captchaError")
    }


    deinit {
        print("VkDelegateImpl was destroyed")
    }

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print("vkSdkAccessAuthorizationFinished")
    }

    func vkSdkUserAuthorizationFailed() {
        print("vkSdkUserAuthorizationFailed")
    }
}
