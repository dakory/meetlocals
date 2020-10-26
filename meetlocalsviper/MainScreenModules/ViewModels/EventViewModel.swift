//
//  EventViewModel.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import Foundation

struct EventViewModel {
    let description: String

    init(description: String) {
        self.description = "Предлагает: \(description.lowercased())"
    }
}
