//
//  SegmentedControl + Extension.swift
//  iChat
//
//  Created by Виталий Сосин on 13.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    
    convenience init(first: String, second: String, backgroundColor: UIColor = .systemGray6) {
        self.init()
        
        self.insertSegment(withTitle: first, at: 0, animated: true)
        self.insertSegment(withTitle: second, at: 1, animated: true)
        self.selectedSegmentIndex = 0
        self.backgroundColor = backgroundColor
    }
}
