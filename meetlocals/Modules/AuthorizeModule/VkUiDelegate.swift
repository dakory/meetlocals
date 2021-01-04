//
// Created by AkhIgor on 24.10.2020.
//

import Foundation
import VK_ios_sdk

class VkUiDelegate: NSObject, VKSdkUIDelegate {

    deinit {
        print("VkUiDelegate was destroyed")
    }

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        let window = UIWindow()
        window.rootViewController = controller
        window.makeKeyAndVisible()
        (UIApplication.shared.delegate as! AppDelegate).window = window
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("vkSdkNeedCaptchaEnter(_ captchaError")
    }

}
