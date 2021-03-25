//
//  Person.swift
//  Kolobok
//
//  Created by Виктор Марусин on 11.12.2020.
//

import UIKit
import MessageKit

struct Person: SenderType {
    
    var displayName: String
    var senderId: String
    
    init(displayName: String, senderId: String) {
        self.displayName = displayName
        self.senderId = senderId
    }
    
    //функция hash что бы мы понимали по какому критерию будет сортировка (функция из презентации Apple)
    func hash(into hasher: inout Hasher) {
        hasher.combine(displayName)
    }
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.displayName == rhs.displayName
    }
}

let personIco = ["Дед" : #imageLiteral(resourceName: "ded"),
                 "Баба" : #imageLiteral(resourceName: "baba"),
                 "Колобок" : #imageLiteral(resourceName: "kolobok"),
                 "Заяц" : #imageLiteral(resourceName: "zayac"),
                 "Волк" : #imageLiteral(resourceName: "wolf"),
                 "Медведь" : #imageLiteral(resourceName: "bear"),
                 "Лиса" : #imageLiteral(resourceName: "fox")]

let ded = Person(displayName: "Дед", senderId: "1")
let baba = Person(displayName: "Баба", senderId: "2")
let kolobok = Person(displayName: "Колобок", senderId: "1")
let rabbit = Person(displayName: "Заяц", senderId: "2")
let wolf = Person(displayName: "Волк", senderId: "1")
let bear = Person(displayName: "Медведь", senderId: "2")
let fox = Person(displayName: "Лиса", senderId: "1")

//import RealmSwift

//class Person: Object {
//    @objc dynamic var name: String = ""
//
//   // let dialogs = List<Dialog>()
//
////сообщает Realm что id уникален
//    override static func primaryKey() -> String? {
//        return "name"
//    }
//}



