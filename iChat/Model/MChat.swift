//
//  MChat.swift
//  iChat
//
//  Created by Виталий Сосин on 14.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

struct MChat: Hashable, Decodable {
    var username: String
    var userImageString: String
    var lastMessage: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.id == rhs.id
    }
}
