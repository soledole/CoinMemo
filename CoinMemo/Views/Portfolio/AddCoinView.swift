//
//  AddCoinView.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 26/07/2022.
//

import SwiftUI

struct AddCoinView: View {
    
    @EnvironmentObject var portfolioDataManager: PortfolioDataManager
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showingAlert = false
    @State private var alertType = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Add coin")
                    .font(.title)
                Spacer()
                
                Button(action: {
                    portfolioDataManager.loadPortfolioFromAPI()
                    portfolioDataManager.saveCoinListToFile()
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 20))
                })
            }
            .padding(.bottom, 30)
            
            VStack {
                SearchBarView(searchText: $searchText, isSearching: $isSearching)
                    .disableAutocorrection(true)
                    .autocapitalization(.allCharacters)
                
                List {
                    ForEach(portfolioDataManager.coinsList.keys.filter({ (coin: String) -> Bool in
                        return coin.hasPrefix(searchText) || searchText == ""
                    }), id: \.self) { coin in
                        
                        HStack {
                            Text(coin)
                            Spacer()
                            
                            Button(action: {
                                showingAlert = true
                                if (searchCoin(name: coin)) {
                                    alertType = true
                                } else {
                                    alertType = false
                                    
                                    let newCoin = Coin(name: coin, marketValue: 0, volume: 0, transaction: [])
                                    portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin.append(newCoin)
                                    portfolioDataManager.savePortfolioToFile()
                                }
                            }, label: {
                                Image(systemName: "chevron.right")
                            }) //:BUTTON
                            .alert(alertType ? "Coin is already on your list" : "You added coin to list", isPresented: $showingAlert) {
                                Button("OK", role: .cancel) {}
                            }
                        }
                    }
                } //: LIST
                .listStyle(.plain)
                .gesture(DragGesture()
                    .onChanged({ _ in
                        UIApplication.shared.dismissKeyboard()
                    })
                )
            }
        } //: VSTACK
        .padding()
    }
    
    //MARK: - Functions
    
    private func searchCoin(name: String) -> Bool {
        print("-> searchCoin(name: \(name), portfolio: \(portfolioDataManager.selectedPortfolio))")
        
        for coin in portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].coin {
            if (coin.name == name) {
                print("<- true")
                return true
            }
        }
        print("<- false")
        return false
    }
}

struct AddCoinView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoinView()
            .preferredColorScheme(.dark)
    }
}
