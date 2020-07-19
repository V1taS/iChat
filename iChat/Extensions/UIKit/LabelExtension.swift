//
//  Label + extension.swift
//  iChat
//
//  Created by Виталий Сосин on 12.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String,
                     font: UIFont? = .avenir20(),
                     color: UIColor = .black,
                     numberOfLines: Int = 0,
                     textAlignment: NSTextAlignment = .left) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        
        
    }
}
