//
//  DataManager.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 08/08/2022.
//

import Foundation

class PortfolioDataManager: ObservableObject {
    @Published var portfolioArray: [Portfolio] = []
    @Published var selectedPortfolio: Int = 0
    @Published var selectedCoin: Int = 0
    @Published var coinsList: [String: String] = [:]
    
    init() {
        if checkIfPortfolioFileExist() == true {
            readPortfolioFromFile()
        } else {
            readPortfolioFromBundle()
        }
        if checkIfCoinListExist() == true {
            readCoinListFromFile()
        } else {
            loadCoinListFromAPI()
        }
    }
    
    func checkIfPortfolioFileExist() -> Bool {
        print("-> checkIfPortfolioFileExist() - folder path below")
        print(FileManager.documentsDirectory.absoluteString.dropFirst(7))
        
        let filePath = FileManager.documentsDirectory.path + "/portfolio.json"
        if FileManager.default.fileExists(atPath: filePath) {
            print("<- exist")
            return true
        } else {
            print("<- not exist")
            return false
        }
    }
    
    func readPortfolioFromFile() {
        do {
            let url = FileManager.documentsDirectory
                .appendingPathComponent("portfolio")
                .appendingPathExtension("json")
            print("readPortfolioFromFile()")
            
            let data = try Data(contentsOf: url)
            let jsonData = try JSONDecoder().decode([Portfolio].self, from: data)
            portfolioArray = jsonData
        } catch {
            print("error reading from file: \(error)")
        }
    }
    
    func readPortfolioFromBundle() {
        do {
            let url = Bundle.main.url(forResource: "emptyPortfolio", withExtension: "json")!
            print("readPortfolioFromBundle()")
            
            let data = try Data(contentsOf: url)
            let jsonData = try JSONDecoder().decode([Portfolio].self, from: data)
            portfolioArray = jsonData
        } catch {
            print("error reading from bundle: \(error)")
        }
    }
    
    func savePortfolioToFile() {
        do {
            let url = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("portfolio")
                .appendingPathExtension("json")
            print("savePortfolioToFile()")
            let data = try JSONEncoder().encode(portfolioArray)
            try data.write(to: url, options: .completeFileProtection)
        } catch {
            print("error saving to file: \(error)")
        }
    }
    
    func checkIfCoinListExist() -> Bool {
        print("-> checkIfCoinListExist()")
        let filePath = FileManager.documentsDirectory.path + "/coinlist.json"
        if FileManager.default.fileExists(atPath: filePath) {
            print("<- exist")
            return true
        } else {
            print("<- not exist")
            return false
        }
    }
    
    func readCoinListFromFile() {
        do {
            let url = FileManager.documentsDirectory
                .appendingPathComponent("coinlist")
                .appendingPathExtension("json")
            print("readCoinListFromFile()")
            
            let data = try Data(contentsOf: url)
            let jsonData = try JSONDecoder().decode([String:String].self, from: data)
            coinsList = jsonData
        } catch {
            print("error reading from file: \(error)")
        }
    }
    
    func loadCoinListFromAPI() {
        CoinGeckoAPI().getCoinList() { (coins) in
            for coin in coins.enumerated() {
                self.coinsList[coins[coin.offset].symbol.uppercased()] = coins[coin.offset].id
            }
        }
        print("loadCoinListFromAPI()")
    }
    
    func saveCoinListToFile() {
        do {
            let url = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("coinlist")
                .appendingPathExtension("json")
            print("saveCoinListToFile()")
            let data = try JSONEncoder().encode(coinsList)
            try data.write(to: url)
        } catch {
            print("error saving to file: \(error)")
        }
    }
    
    func searchCoin(name: String) -> Bool {
        print("-> searchCoin(name: \(name), portfolio: \(selectedPortfolio))")
        for coin in portfolioArray[selectedPortfolio].coin {
            if (coin.name == name) {
                print("<- true")
                return true
            }
        }
        print("<- false")
        return false
    }
}
