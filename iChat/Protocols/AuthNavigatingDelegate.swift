//
//  AuthNavigatingDelegate.swift
//  iChat
//
//  Created by Виталий Сосин on 16.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol AuthNavigatingDelegate: class {
    func toLoginVC()
    func toSignUpVC()
}
