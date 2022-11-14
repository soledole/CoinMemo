//
//  BadgeColorModel.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 14/11/2022.
//

import Foundation

struct BadgeColor: Codable, Equatable {
    var red: Double
    var green: Double
    var blue: Double
}

let colorPicker = [
    BadgeColor(red: 0/255, green: 151/255, blue: 230/255),
    BadgeColor(red: 140/255, green: 122/255, blue: 230/255),
    BadgeColor(red: 251/255, green: 197/255, blue: 49/255),
    BadgeColor(red: 68/255, green: 189/255, blue: 50/255),
    BadgeColor(red: 72/255, green: 126/255, blue: 176/255),
    BadgeColor(red: 194/255, green: 54/255, blue: 22/255),
    BadgeColor(red: 113/255, green: 128/255, blue: 147/255),
    BadgeColor(red: 25/255, green: 42/255, blue: 86/255),
    BadgeColor(red: 53/255, green: 59/255, blue: 72/255)
]
