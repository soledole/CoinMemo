//
//  ValueBadgeView.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 26/07/2022.
//

import SwiftUI

struct BadgeView: View {
    
    @EnvironmentObject var portfolioDataManager: PortfolioDataManager
    @State private var isShowingSettins = false
    
    var body: some View {
        VStack {
            HStack {
                Text(portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].name)
                
                Spacer()
                
                Button(action: {
                    isShowingSettins = true
                }, label: {
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                }) //: BUTTON
                .sheet(isPresented: $isShowingSettins, content: {
                    PortfolioSettingsView(colorSelected: emptyColorSelected)
                })
            }
            
            HStack {
                Text(currency + String(format: "%.1f", portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].account_value))
                    .font(.title).bold()
                    .monospacedDigit()
                
                Spacer()
            }
        } //: VSTACK
        .padding()
        //better idea to write this
        .background(Color(red: portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].badge_color.red, green: portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].badge_color.green, blue: portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].badge_color.blue))
        .cornerRadius(15)
        .foregroundColor(.white)
        
    }
}

struct ValueBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
