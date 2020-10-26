//
//  AppDelegate.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let contex = MeetlocalsMainscreenContext(moduleOutput: nil)
        let container = MeetlocalsMainscreenContainer.assemble(with: contex)
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = container.viewController
        window.makeKeyAndVisible()
        
        return true
    }


}

