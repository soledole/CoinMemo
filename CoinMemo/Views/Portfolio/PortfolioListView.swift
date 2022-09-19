//
//  PortfolioListView.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 19/09/2022.
//

import SwiftUI

struct PortfolioListView: View {
    
    @EnvironmentObject var portfolioDataManager: PortfolioDataManager
    @State private var isShowingAlert = false
    @State private var deleteIndexSet: IndexSet?
    @State private var isShowingAddView = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Portfolios List")
                    .font(.title)
                Spacer()
                
                Button(action: {
                    isShowingAddView = true
                }, label: {
                    Image(systemName: "cross")
                        .font(.system(size: 20))
                }) //: BUTTON
                .sheet(isPresented: $isShowingAddView, content: {
                    AddPortfolioView()
                })
            }
            .padding(.bottom, 30)
            
            List {
                ForEach(portfolioDataManager.portfolioArray) { portfolio in
                    Text(portfolio.name)
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
                    Text("Are you sure you want delete this portfolio?")
                }
            }
            .listStyle(.plain)
            
        } //: VSTACK
        .padding()
    }
    
    //MARK: - Functions
    
    private func delete(at offsets: IndexSet) {
        portfolioDataManager.portfolioArray.remove(atOffsets: offsets)
        portfolioDataManager.savePortfolioToFile()
    }
}

struct PortfolioListView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioListView()
            .preferredColorScheme(.dark)
    }
}
