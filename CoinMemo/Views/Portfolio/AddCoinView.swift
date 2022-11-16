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
                    portfolioDataManager.loadCoinListFromAPI()
                    portfolioDataManager.saveCoinListToFile()
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 20))
                })
            }
            .padding(.bottom, 30)
            
            VStack {
                //SearchBar
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search...", text: $searchText) { startedEditing in
                            if startedEditing {
                                withAnimation {
                                    isSearching = true
                                }
                            }
                        } onCommit: {
                            CoinGeckoAPI().getCoin(for: searchText) { (coin) in
                                let replecingCurrent = portfolioDataManager.coinsList.merging(coin) { (_, new) in new }
                                portfolioDataManager.coinsList = replecingCurrent
                            }
                            withAnimation {
                                isSearching = false
                            }
                        }
                        .disableAutocorrection(true)
                        .autocapitalization(.allCharacters)
                        
                        if isSearching {
                            Button(action: {
                                searchText = ""
                                isSearching = false
                                UIApplication.shared.dismissKeyboard()
                            }, label: {
                                Text("Cancel")
                                    .foregroundColor(.accentColor)
                            })
                        }
                    } //: HSTACK
                    .padding([.leading, .trailing], 10)
                } //: ZSTACK
                .frame(height: 40)
                .cornerRadius(10)
                
                List {
                    let sortedKeys = Array(portfolioDataManager.coinsList.keys).sorted(by: <)
                    ForEach(sortedKeys.filter({ (coin: String) -> Bool in
                        return coin.hasPrefix(searchText) || searchText == ""
                    }), id: \.self) { coin in
                        
                        HStack {
                            Text(coin)
                            Spacer()
                            
                            Button(action: {
                                showingAlert = true
                                if (portfolioDataManager.searchCoin(name: coin)) {
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
}

struct AddCoinView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoinView()
            .preferredColorScheme(.dark)
    }
}
