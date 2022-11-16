//
//  CoinListModel.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 14/11/2022.
//

import Foundation

struct CoinList: Codable, Hashable {
    var symbol: String
    var id: String
}

struct CoinSearch: Codable {
    var coins: [Coin2]
}

struct Coin2: Codable, Hashable {
    var name: String
    var symbol: String
}
