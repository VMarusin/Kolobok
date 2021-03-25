//
//  UserSettings.swift
//  Kolobok
//
//  Created by Виктор Марусин on 09.02.2021.
//

import Foundation

//здесь храним пользовательские настройки
final class UserSettings {
    
    private enum SettingsKeys: String {
        case position // здесь храним текущую позицию чата
    }
    
    static var position: Int! {
        get {
            return UserDefaults.standard.integer(forKey: SettingsKeys.position.rawValue) // здесть доставем текущее значение
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.position.rawValue
            if let name = newValue {
                print("value: \(name) was added to key \(key)") //потом удалим
                defaults.set(name, forKey: key)  //сохраняем новое значение
            } else {
                defaults.removeObject(forKey: key) // если получаем nil то обнуляем
            }
        }
    }
}

