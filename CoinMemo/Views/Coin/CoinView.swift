//
//  CoinView.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 26/07/2022.
//

import SwiftUI

struct CoinView: View {
    
    @EnvironmentObject var portfolioDataManager: PortfolioDataManager
    private var gridItem: [GridItem] {
        Array(repeating: .init(.flexible()), count: 2)
    }
    @State var coin: Coin
    @State private var isShowingAddView = false
    @State private var deleteIndexSet: IndexSet?
    //Datas for reload
    @State private var volume: Double = 0
    @State private var cost: Double = 0
    @State private var avgPrice: Double = 0
    @State private var profit: Double = 0
    @State private var change: Double = 0
    
    var body: some View {
        VStack {
            LazyVGrid(columns: gridItem, spacing: 50) {
                VStack {
                    Text("MARKET VALUE")
                        .font(.caption2)
                    Text(String(format: "%.2f", coin.marketValue))
                        .font(.body).bold()
                }
                VStack {
                    Text("VOLUME")
                        .font(.caption2)
                    
                    Text(String(format: "%.2f", volume))
                        .font(.body).bold()
                }
                VStack {
                    Text("COST")
                        .font(.caption2)
                    
                    Text(String(format: "%.1f", cost))
                        .font(.body).bold()
                }
                VStack {
                    Text("AVG. PRICE")
                        .font(.caption2)
                    
                    Text(String(format: "%.2f", avgPrice))
                        .font(.body).bold()
                }
                VStack {
                    Text("PROFIT")
                        .font(.caption2)
                    
                    Text(String(format: "%.1f", profit))
                        .font(.body).bold()
                }
                VStack {
                    Text("% CHANGE")
                        .font(.caption2)
                    
                    Text(String(format: "%.2f", change))
                        .font(.body).bold()
                }
            } //: VGRID
            .monospacedDigit()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(coin.name)
                        .font(.title)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingAddView = true
                    }, label: {
                        Image(systemName: "cross")
                            .font(.system(size: 15))
                    })
                    .sheet(isPresented: $isShowingAddView, onDismiss: {
                        resetValues()
                        reloadData()
                    }, content: {
                        AddTransactionView(coin: coin)
                    })
                }
            } //: TOOLBAR
            .padding([.top, .bottom], 30)
            
            HStack {
                Text("Transactions")
                    .font(.title2)
                Spacer()
            }
            .padding([.leading, .trailing], 15)
            .padding(.bottom, -10)
            
            List {
                Section(header:
                    HStack {
                        Text("VOLUME")
                        Spacer()
                        Text("PRICE")
                        Spacer()
                        Text("% CHANGE")
                    }
                ) {
                    ForEach(portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin[portfolioDataManager.selectedCoin].transaction, id: \.self) { transaction in
                        TransactionTableItemView(transaction: transaction, coinMarketValue: coin.marketValue)
                    }
                    .onDelete(perform: { indexSet in
                        deleteIndexSet = indexSet
                        delete(at: deleteIndexSet!)
                    })
                }
            } //: LIST
            .monospacedDigit()
        } //: VSTACK
        .onAppear(perform: reloadData)
    }
    
    //MARK: - Functions
    
    private func reloadData() {
        coin = portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin[portfolioDataManager.selectedCoin] // Set up coin
        print("reloadData")
        countVolume()
        if volume == 0 {
            avgPrice = 0
            cost = 0
            profit = 0
            change = 0
            portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin[portfolioDataManager.selectedCoin].volume = volume
            portfolioDataManager.savePortfolioToFile()
            return
        }
        countAVGPrice()
        countChange()
        countCost()
        countProfit()

        portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin[portfolioDataManager.selectedCoin].volume = volume
        portfolioDataManager.savePortfolioToFile()
    }
    
    private func countVolume() {
        for transaction in coin.transaction.enumerated() {
            
            if coin.transaction[transaction.offset].type == true {
                volume += transaction.element.volume
            } else {
                volume -= transaction.element.volume
            }
        }
    }
    
    private func countAVGPrice() {
        for transaction in coin.transaction.enumerated() {
            let transactionPrice = coin.transaction[transaction.offset].volume * coin.transaction[transaction.offset].price
            
            if coin.transaction[transaction.offset].type == true {
                avgPrice += transactionPrice
            } else {
                avgPrice -= transactionPrice
            }
        }
        avgPrice /= volume
    }
    
    private func countChange() {
        change = (coin.marketValue * 100) / avgPrice - 100
    }
    
    private func countCost() {
        cost = volume * avgPrice
    }
    
    private func countProfit() {
        profit = cost * (change / 100)
    }
    
    private func delete(at offsets: IndexSet) {
        coin.transaction.remove(atOffsets: offsets)
        portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin[portfolioDataManager.selectedCoin].transaction.remove(atOffsets: offsets)
        resetValues()
        reloadData()
    }
    
    private func resetValues() {
        volume = 0
        avgPrice = 0
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CoinView(coin: emptyCoin)
    }
}
