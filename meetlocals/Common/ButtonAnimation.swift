//
//  ButtonAnimation.swift
//  meetlocals
//
//  Created by Софья Тимохина on 10.01.2021.
//

import Foundation
import UIKit

extension UIButton {
    func tap() {
        let duration: TimeInterval = 0.2
        let easingOffset: CGFloat = -0.05
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
            }, completion: { (completed: Bool) -> Void in
                UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                    self.transform = .identity
                    }, completion: { (completed: Bool) -> Void in
                })
        })
    }
}
