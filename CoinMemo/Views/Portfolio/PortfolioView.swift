//
//  ContentView.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 26/07/2022.
//

import SwiftUI

struct PortfolioView: View {
    
    @State private var isShowingAddView = false
    @State private var isShowingListView = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text(appName)
                        .font(.title2)
                    
                    Spacer()
                    
                    Button(action: {
                        isShowingListView = true
                    }, label: {
                        Image(systemName: "books.vertical")
                            .font(.system(size: 20))
                    }) //: BUTTON
                    .sheet(isPresented: $isShowingListView, content: {
                        PortfolioListView()
                    })
                    
                    Button(action: {
                        isShowingAddView = true
                    }, label: {
                        Image(systemName: "cross")
                            .font(.system(size: 20))
                    }) //: BUTTON
                    .sheet(isPresented: $isShowingAddView, content: {
                        AddCoinView()
                    })
                    
                } //: HSTACK
                .padding([.top, .bottom], 15)
                .foregroundColor(.white)
                
                BadgeView()
                
                CoinTableView()
                    .padding([.top, .bottom], 10)
            } //: VSTACK
            .preferredColorScheme(.dark)
            .navigationBarHidden(true)
            .padding([.leading, .trailing], 5)
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
