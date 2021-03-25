//
//  Dialog.swift
//  Kolobok
//
//  Created by Виктор Марусин on 11.12.2020.
//

import UIKit
import MessageKit
//import RealmSwift

struct ImageItem: MediaItem {

    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}

struct Message: Hashable, MessageType {
    
    let content: String
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var status: String
    var answerOne: String
    var answerTwo: String
    var transitionOne: Int
    var transitionTwo: Int
    var kind: MessageKind
//    {
//        //проверяем что поступает на вход картинка или текст
//        if let image = image {
//            let mediaItem = ImageItem(url: nil, image: nil, placeholderImage: image, size: image.size)
//            return .photo(mediaItem)
//        } else {
//            return.text(content)
//        }
//    }
    
//    init(user: Person, content: String) {
//        sender = Sender(senderId: user.id, displayName: user.name)
//        self.content = content
//        sentDate = Date()
//    }
//    
//    init(user: Person, image: UIImage) {
//        sender = Sender(senderId: user.id, displayName: user.name)
//        self.image = image
//        content = ""
//        sentDate = Date()
//     }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    //подписываем модель данных под протокол Equatadle (для чата). Т.е как мы их будем идентифицировать (правое и левое)
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.messageId == rhs.messageId
    }
}

// здесь описываем как мы будем сортировать массив чата
extension Message: Comparable {
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate //сортируем по времени их добавления
    }
}
