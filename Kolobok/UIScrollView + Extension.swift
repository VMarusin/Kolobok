//
//  UIScrollView + Extension.swift
//  Kolobok
//
//  Created by Виктор Марусин on 25.03.2021.
//

import Foundation
import UIKit

//проверяем проверки фокуса сообщения для смещения экрана
extension UIScrollView {

    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }

    // фунация проверяет на каком участке сообщения мы находимся
    var verticalOffsetForBottom: CGFloat {
      let scrollViewHeight = bounds.height
      let scrollContentSizeHeight = contentSize.height
      let bottomInset = contentInset.bottom
      let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
      return scrollViewBottomOffset
    }
}
