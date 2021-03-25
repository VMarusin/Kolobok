//
//  UIButton + Extension.swift
//  Kolobok
//
//  Created by Виктор Марусин on 20.01.2021.
//

import Foundation
import UIKit

//делаем универсальное расширение для отрисовки кнопок
extension UIButton {
    
    convenience init(title: String,
                     titleColor: UIColor,
                     backgroundColor: UIColor,
                     font: UIFont? = .avenir20(), //значение по умолчанию если мы ни чего не указываем в инициализаторе
                     isShadow: Bool = false,
                     cornerRadius: CGFloat = 20) { // значение по умолчанию
        self.init(type: .system) // type: .system включает блик при нажатии кнопки
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.numberOfLines = 2
        self.layer.cornerRadius = cornerRadius
        self.titleEdgeInsets = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 6)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.1
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.textAlignment = .left
        self.titleLabel?.allowsDefaultTighteningForTruncation = true
        self.titleLabel?.sizeToFit()
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2 // блик
            self.layer.shadowOffset = CGSize(width: 0, height: 4)//в какую сторону будет уходить
        }
    }
    
    //добавляем кастомное изображение на кнопку
//    func customizeGooglaButton() {
//        let googleLogo = UIImageView(image: #imageLiteral(resourceName: "googleLogo"), contentMode: .scaleAspectFit)
//        googleLogo.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(googleLogo)
//        googleLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
//        googleLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//    }
}
