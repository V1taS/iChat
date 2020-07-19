//
//  WaitingChatsNavigation.swift
//  iChat
//
//  Created by Виталий Сосин on 18.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol WaitingChatsNavigation: class {
    func removeWaitingChat(chat: MChat)
    func changeToActive(chat: MChat)
}
