//
// Created by Dmitry Koryakin on 31.10.2020.
//

// Можно удалить
import UIKit

extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.clipsToBounds = true
    }
}
