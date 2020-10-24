//
// Created by AkhIgor on 24.10.2020.
//

import Foundation
import VK_ios_sdk

class VkDelegate: NSObject, VKSdkDelegate {

    deinit {
        print("VkDelegate was destroyed")
    }

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print("vkSdkAccessAuthorizationFinished")
    }

    func vkSdkUserAuthorizationFailed() {
        print("vkSdkUserAuthorizationFailed")
    }

}
