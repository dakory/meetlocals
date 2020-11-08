//
//  EventViewModel.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

struct EventViewModel {
    let description: String
    let userName: String
    let eventName: String
    let userImage: String

    init(description: String, userName: String, eventName: String, userImage: String) {
        self.eventName = "Хочет \(eventName.lowercased())"
        self.description = description
        self.userName = userName
        self.userImage = userImage
    }
}
