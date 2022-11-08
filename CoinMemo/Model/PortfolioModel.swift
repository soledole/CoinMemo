//
//  PortfolioModel.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 07/08/2022.
//

import Foundation

struct Portfolio: Identifiable, Codable {
    var id: Int
    var name: String
    var account_value: Double
    var badge_color: BadgeColor
    var refresh_date: String
    var coin: [Coin]
}

struct BadgeColor: Codable, Equatable {
    var red: Double
    var green: Double
    var blue: Double
}

struct Coin: Codable, Hashable {
    var name: String
    var marketValue: Double
    var volume: Double
    var transaction: [Transaction]
}

struct Transaction: Codable, Hashable {
    var type: Bool
    var volume: Double
    var price: Double
    var date: String
}

struct CoinList: Codable, Hashable {
    var symbol: String
    var id: String
}
