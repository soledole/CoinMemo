//
//  Constant.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 26/07/2022.
//

import Foundation

struct Defaults {
    static let currency = "$"
    static let fetchCurrency = "usd"
    static let dateFormat = "dd MMM HH:mm:ss"
}

struct MockData {
    static let emptyColorSelected = BadgeColor(red: 1, green: 1, blue: 1)
    static let emptyCoin = Coin(name: "BTC", marketValue: 0, volume: 0, transaction: [])
    static let emptyTransaction = Transaction(type: true, volume: 0, price: 0, date: "")
}
