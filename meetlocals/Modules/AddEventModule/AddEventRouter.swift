//
//  AddEventRouter.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class AddEventRouter {
    var viewController: UIViewController?

    weak var output: AddEventRouterOutput?
}

extension AddEventRouter: AddEventRouterInput {

}
