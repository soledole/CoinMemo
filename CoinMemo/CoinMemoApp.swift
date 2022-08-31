//
//  CoinMemoApp.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 26/07/2022.
//

import SwiftUI

@main
struct CoinMemoApp: App {
    var body: some Scene {
        WindowGroup {
            PortfolioView()
                .environmentObject(PortfolioDataManager())
        }
    }
}
