//
// Created by AkhIgor on 20.10.2020.
//

import Foundation
import VK_ios_sdk

struct VkInfo {
    public static let APPLICATION_ID = "7635135"
    public static let SOURCE_KEY = "1SQs9CUM6rclF6G27qfw"
    public static let SERVICE_KEY = "cb319391cb319391cb31939104cb45132eccb31cb31939194bf2005f1c8ad941136aea5"

    public static let PERMISSIONS = [VK_PER_FRIENDS, VK_PER_EMAIL]
    public static let VK_AUTHORIZATION_URL = URL(string: "vk\(VkInfo.APPLICATION_ID)")!
}
