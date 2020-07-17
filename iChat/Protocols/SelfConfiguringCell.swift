//
//  SelfConfiguringCell.swift
//  iChat
//
//  Created by Виталий Сосин on 14.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
