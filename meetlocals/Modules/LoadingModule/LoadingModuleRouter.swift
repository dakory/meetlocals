//
//  LoadingModuleRouter.swift
//  meetlocals
//
//  Created by Dmitry Koryakin on 05.01.2021.
//  
//

import UIKit

final class LoadingModuleRouter {
    weak var output: LoadingRouterOutput?
}

extension LoadingModuleRouter: LoadingModuleRouterInput {
    func showTabBar() {
        self.output?.moduleOutput?.setupTabBar()
        self.output?.moduleOutput?.window?.rootViewController = self.output?.moduleOutput?
                .tabBar
        self.output?.moduleOutput?.window?.makeKeyAndVisible()
    }
}
