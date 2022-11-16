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
    BadgeColor(red: 47/255, green: 54/255, blue: 64/255),
    BadgeColor(red: 53/255, green: 59/255, blue: 72/255),
    BadgeColor(red: 25/255, green: 42/255, blue: 86/255),
    BadgeColor(red: 39/255, green: 60/255, blue: 117/255),
    BadgeColor(red: 64/255, green: 115/255, blue: 158/255),
    BadgeColor(red: 72/255, green: 126/255, blue: 176/255),
    BadgeColor(red: 113/255, green: 128/255, blue: 147/255),
    BadgeColor(red: 127/255, green: 143/255, blue: 166/255),
    BadgeColor(red: 194/255, green: 54/255, blue: 22/255),
    BadgeColor(red: 232/255, green: 65/255, blue: 24/255),
    BadgeColor(red: 255/255, green: 177/255, blue: 44/255),
    BadgeColor(red: 251/255, green: 197/255, blue: 49/255),
    BadgeColor(red: 140/255, green: 122/255, blue: 230/255),
    BadgeColor(red: 156/255, green: 136/255, blue: 255/255),
    BadgeColor(red: 0/255, green: 151/255, blue: 230/255),
    BadgeColor(red: 0/255, green: 168/255, blue: 255/255)
]
