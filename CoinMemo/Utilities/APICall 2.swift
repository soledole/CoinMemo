//
//  APICall.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 09/08/2022.
//

import SwiftUI

struct CoinGeckoAPI {
    
    func fetchDataForCoins(for coins: [String], in currency: String, completion: @escaping ([Any]) -> ()) {
        
        var coinsString = ""
        
        for coin in coins {
            coinsString += coin+","
        }
        coinsString.removeLast() //Remove last comma for proper url
        
        var readyCoins:[Any] = []
        
        if let url = URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=\(coinsString)&vs_currencies=\(currency)") {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let safeData = data {
                    do {
                        if let jsonCoin = try JSONSerialization.jsonObject(with: safeData) as? [String:[String:Any]] {
                            
                            DispatchQueue.main.async {
                                
                                for coin in coins {
                                    
                                    if let currency2 = jsonCoin[coin] {

                                        if let value = currency2[currency] {

                                            readyCoins.append(value as! NSNumber)
                                        }
                                    }
                                }
                                print("fetchDataForCoins() \(readyCoins)")
                                completion(readyCoins)
                            }
                        }
                    } catch {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                }
            } //: SESSION
            task.resume()
        }
    }
    
    func getCoinList(completion: @escaping ([CoinList]) -> ()) {
        
        if let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false") {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let safeData = data {
                    do {
                        let result = try JSONDecoder().decode([CoinList].self, from: safeData)
                        DispatchQueue.main.async {
                            completion(result)
                        }
                    } catch {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                }
            } //: SESSION
            task.resume()
        }
    }
    
    func getCoin(for coin: String, completion: @escaping ([String: String]) -> ()) {
        
        var readyCoinsList: [String: String] = [:]
        
        if let url = URL(string: "https://api.coingecko.com/api/v3/search?query=\(coin)") {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error)  in
                
                if let safeData = data {
                    do {
                        let result = try JSONDecoder().decode(CoinSearch.self, from: safeData)
                        DispatchQueue.main.async {
                            for coin in result.coins.enumerated() {
                                readyCoinsList[result.coins[coin.offset].symbol.uppercased()] = result.coins[coin.offset].name
                            }
                            completion(readyCoinsList)
                        }
                    } catch {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                }
            } //: SESSION
            task.resume()
        }
    }
}
