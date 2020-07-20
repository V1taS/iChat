//
//  UIButton + extension.swift
//  iChat
//
//  Created by Виталий Сосин on 12.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(title: String,
                     titleColor: UIColor,
                     backgroundColor: UIColor,
                     font: UIFont? = .avenir14(),
                     isShadow: Bool = false,
                     cornerRadius: CGFloat = 2,
                     borderColor: UIColor = .systemGray4,
                     borderWidth: Int = 1,
                     widthAnchor: Int = 250,
                     heightAnchor: Int = 40,
                     logo: UIImage? = #imageLiteral(resourceName: "alpha")) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        
        self.layer.cornerRadius = cornerRadius
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = CGFloat(borderWidth)
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
        self.widthAnchor.constraint(equalToConstant: CGFloat(widthAnchor)).isActive = true
        self.heightAnchor.constraint(equalToConstant: CGFloat(heightAnchor)).isActive = true
        
//        let newLogo = self.resizeImage(image: logo!, targetSize: CGSize(width:28, height: 28))
        self.customizeLogoButton(logo!)
    }
    
    // Добавляет иконку к кнопке
    func customizeLogoButton(_ image: UIImage) {
        let Logo = UIImageView(image: image, contentMode: .scaleAspectFit)
        Logo.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(Logo)
        Logo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        Logo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    // Делает маленький размер иконки для кнопки
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
}
