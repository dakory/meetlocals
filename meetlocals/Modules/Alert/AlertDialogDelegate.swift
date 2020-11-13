//
// Created by 17099611 on 12.11.2020.
//

import Foundation
import UIKit

class AlertDialogDelegate: NSObject, UIAlertViewDelegate {

    var alertDialogDescription: AlertDialogDescription

    init(alertDescription: AlertDialogDescription) {
        alertDialogDescription = alertDescription
    }

    func show(viewController: UIViewController?) {
        if (viewController != nil) {
            let alert = UIAlertController(
                    title: alertDialogDescription.title,
                    message: alertDialogDescription.subtitle,
                    preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(
                    title: alertDialogDescription.positiveButtonText,
                    style: UIAlertAction.Style.default
            ) { action in
                self.alertDialogDescription.positiveButtonAction()
            })

            alert.addAction(UIAlertAction(
                    title: alertDialogDescription.negativeButtonText,
                    style: UIAlertAction.Style.default
            ) { action in
                self.alertDialogDescription.negativeButtonAction()
            })

            viewController!.present(alert, animated: true, completion: nil)
        }
    }

}
