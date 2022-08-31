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
    
    init() {
        if checkIfFileExist() == true {
            readPortfolioFromDocument()
        } else {
            readPortfolioFromBundle()
        }
    }
    
    func readPortfolioFromDocument() {
        do {
            let url = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("portfolio")
                .appendingPathExtension("json")
            print("readPortfolioFromDocument()")
            
            let data = try Data(contentsOf: url)
            let jsonData = try JSONDecoder().decode([Portfolio].self, from: data)
            portfolioArray = jsonData
        } catch {
            print("error reading from document: \(error)")
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
            try data.write(to: url)
        } catch {
            print("error saveing to file: \(error)")
        }
    }
    
    func checkIfFileExist() -> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        print("-> checkIfFileExist() - folder path: \(path)")
        
        let fileManager = FileManager.default
        let filePath = path + "/portfolio.json"
        
        if fileManager.fileExists(atPath: filePath) {
            print("<- file exist")
            return true
        } else {
            print("<- file does not exist")
            return false
        }
    }
}
