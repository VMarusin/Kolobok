//
//  StackView + Extension.swift
//  Kolobok
//
//  Created by Виктор Марусин on 20.01.2021.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }

}
