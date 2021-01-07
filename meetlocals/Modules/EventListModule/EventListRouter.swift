//
//  EventListRouter.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class EventListRouter {
    var viewController: UIViewController?
}

extension EventListRouter: EventListRouterInput {
    
    func goToEventScreen(vc: EventListController, meetingID: Int){ //здесь осуществляем переход на "Профиль организатора"
        let contexEventScreen = EventScreenContext(moduleOutput: nil, meetingID: meetingID)
        let containerEventScreen = EventScreenContainer.assemble(with: contexEventScreen)
        let transition = CATransition()
        transition.duration = 0.6
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        vc.navigationController?.view.layer.add(transition, forKey: kCATransition)
        vc.navigationController?.pushViewController(containerEventScreen.viewController, animated: true)
    }
    
}



    
    

