//
//  CoinTableView.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 26/07/2022.
//

import SwiftUI

struct CoinTableView: View {
    
    @EnvironmentObject var portfolioDataManager: PortfolioDataManager
    @State private var isShowingCoinView = false
    @State private var isShowingAlert = false
    @State private var deleteIndexSet: IndexSet?
    
    var body: some View {
        VStack {
            NavigationLink(destination: CoinView(coin: portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin[portfolioDataManager.selectedCoin]), isActive: $isShowingCoinView) {}
            
            HStack {
                Text("COIN")
                Spacer()
                Text("PRICE")
                Spacer()
                Text("VOLUME")
            }
            .font(.footnote)
            .padding([.leading, .trailing], 15)
            
            List {
                ForEach(Array(portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin.enumerated()), id: \.element) { index, coin in
                    CoinTableItemView(coin: coin.name, marketValue: coin.marketValue, volume: coin.volume)
                        .onTapGesture {
                            isShowingCoinView = true
                            portfolioDataManager.selectedCoin = index
                        }
                }
                .onDelete { indexSet in
                    isShowingAlert = true
                    deleteIndexSet = indexSet
                }
                .confirmationDialog("", isPresented: $isShowingAlert) {
                    Button("Delete", role: .destructive) {
                        delete(at: deleteIndexSet!)
                    }
                } message: {
                    Text("Are you sure you want delete this coin?")
                }
            } //: LIST
            .monospacedDigit()
            .listStyle(.plain)
            .foregroundColor(.white)
            .refreshable {
                print("refresh")
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                
                //not sure if it will be good, have to test it
                if portfolioDataManager.checkIfCoinListExist() == false {
                    portfolioDataManager.saveCoinListToFile()
                }
                changePrices()
                setRefreshDate()
                countBalance()
                portfolioDataManager.savePortfolioToFile()
            }
            .animation(.easeIn(duration: 1), value: portfolioDataManager.selectedPortfolio)
            
            Text(portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].refresh_date)
                .font(.subheadline)
        }
    }
    
    //MARK: - Functions
    
    private func changePrices() {
        var coins: [String] = []
        
        for coin in portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin {
            coins.append(portfolioDataManager.coinsList[coin.name]!)
        }
        
        CoinGeckoAPI().fetchDataForCoins(for: coins, in: Defaults.fetchCurrency) { (prices) in
            
            for index in portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin.enumerated() {
                portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin[index.offset].marketValue = prices[index.offset] as! Double
            }
        }
    }
    
    private func setRefreshDate() {
        let date = getStringFromDate(with: Date.now)
        portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].refresh_date = date
    }
    
    private func countBalance() {
        var balance: Double = 0
        
        for coin in portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin {
            balance += coin.marketValue * coin.volume
        }
        portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].account_value = balance
    }
    
    private func delete(at offsets: IndexSet) {
        if lastCoin() { return }
        portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin.remove(atOffsets: offsets)
        portfolioDataManager.savePortfolioToFile()
        portfolioDataManager.selectedCoin = 0 //Reset after remove selected coin
    }
    
    private func lastCoin() -> Bool {
        if portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin.count <= 1 {
            return true
        }
        return false
    }
    
    private func getStringFromDate(with date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Defaults.dateFormat
            let date = dateFormatter.string(from: date)
            return date
    }
}

struct CoinTableView_Previews: PreviewProvider {
    static var previews: some View {
        CoinTableView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
