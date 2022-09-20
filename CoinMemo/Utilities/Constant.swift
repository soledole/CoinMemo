//
//  Constant.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 26/07/2022.
//

import SwiftUI

let appName = "Coin Memo"
let currency = "$"
let fetchCurrency = "usd"
let dateFormat = "dd MMM HH:mm:ss"
let coinList = [
    "BTC":"bitcoin", "ETH":"ethereum", "BNB":"binancecoin", "AAVE":"aave", "DOGE":"binance-peg-dogecoin"
]

let emptyColorSelected = BadgeColor(red: 1, green: 1, blue: 1)
let emptyCoin = Coin(name: "BTC", marketValue: 0, volume: 0, transaction: [emptyTransaction])
let emptyTransaction = Transaction(type: true, volume: 0, price: 0, date: "8 Aug")

//Color picker
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

//UX
let feedback = UIImpactFeedbackGenerator(style: .medium)
