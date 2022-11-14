//
//  Extension.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 26/07/2022.
//

import SwiftUI

struct Metric: Codable {
    var value: Double
}

extension UIApplication {
  func dismissKeyboard() {
      sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension Metric: CustomStringConvertible {
    var description: String {
        var formattedValue = String(format: "%.8f", value)

        while formattedValue.last == "0" {
            formattedValue.removeLast()
        }
        if formattedValue.last == "." {
            formattedValue.removeLast()
        }
        return formattedValue
    }
    var shortVersion: String {
        var formattedValue = String(format: "%.2f", value)
        
        while formattedValue.last == "0" {
            formattedValue.removeLast()
        }
        if formattedValue.last == "." {
            formattedValue.removeLast()
        }
        return formattedValue
    }
}
