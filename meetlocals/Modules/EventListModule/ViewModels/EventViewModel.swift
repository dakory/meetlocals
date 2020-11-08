//
//  EventViewModel.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

struct EventViewModel {
    let id: Int
    let idOrganizer: Int
    let name: String
    let userImage: String
    let userName: String
    

    init(id: Int, idOrganizer: Int, name: String, description: String) {
        self.name = "Хочет \(name.lowercased())"
        self.id = id
        self.name = name
        // TODO: прописать получение имени пользователя и аватарки из бд.
         self.userImage = "None"
         self.userName = "None"
    }
}
