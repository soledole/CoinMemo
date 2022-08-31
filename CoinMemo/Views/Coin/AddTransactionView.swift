//
//  AddTransactionView.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 10/08/2022.
//

import SwiftUI

struct AddTransactionView: View {
    
    @EnvironmentObject var portfolioDataManager: PortfolioDataManager
    @State var coin: Coin
    @State private var transactionType = false
    @State private var price: Double = 0
    @State private var volume: Double = 0
    @State private var date = Date.now
    @State private var newTransaction: Transaction = emptyTransaction
    @State private var test: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Transaction")
                    .font(.title)
                Spacer()
            }
            .padding(.bottom, 30)
            
            Picker("", selection: $transactionType) {
                Text("Buy").tag(true)
                Text("Sell").tag(false)
            }
            .pickerStyle(.segmented)
            
            List {
                HStack {
                    Text("Price")
                    TextField("", value: $price, format: .number)
                }
                HStack {
                    Text("Volume")
                    TextField("", value: $volume, format: .number)
                }
            }
            .keyboardType(.decimalPad)
            .frame(width: UIScreen.screenWidth, height: 160, alignment: .center)
            
            DatePicker("Date", selection: $date)
            
            Button("Add", action: {
                UIApplication.shared.dismissKeyboard()
                newTransaction.type = transactionType
                newTransaction.price = price
                newTransaction.volume = volume
                newTransaction.date = getStringFromDate(with: date)
                
                portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin[portfolioDataManager.selectedCoin].transaction.append(newTransaction)
                portfolioDataManager.savePortfolioToFile()
            })
            .padding(.top, 30)
            
            Spacer()
        } //: VSTACK
        .padding()
    }
    
    //MARK: - Functions
    
    private func getStringFromDate(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM HH:mm"
        let date = dateFormatter.string(from: date)
        return date
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(coin: emptyCoin)
    }
}
