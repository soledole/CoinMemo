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
    @State private var offset = CGSize.zero
    
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
                    PortfolioSettingsView(colorSelected: MockData.emptyColorSelected)
                })
            }
            
            HStack {
                Text(Defaults.currency + String(format: "%.1f", portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].account_value))
                    .font(.title).bold()
                    .monospacedDigit()
                Spacer()
            }
        } //: VSTACK
        .padding()
        .background(Color(red: portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].badge_color.red, green: portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].badge_color.green, blue: portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].badge_color.blue))
        .cornerRadius(15)
        .offset(x: offset.width * 0.1, y: 0)
        .foregroundColor(.white)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if offset.width < 100 {
                        
                        if portfolioDataManager.selectedPortfolio == portfolioDataManager.portfolioArray.count-1 {
                            print("cant select to right")
                        } else {
                            print("select +1")
                            portfolioDataManager.selectedPortfolio += 1
                        }
                    } else if offset.width > -100 {
                        
                        if portfolioDataManager.selectedPortfolio == 0 {
                            print("cant select to left")
                        } else {
                            print("select -1")
                            portfolioDataManager.selectedPortfolio -= 1
                        }
                    }
                    offset = .zero
                }
        )
        .animation(.easeIn(duration: 0.5), value: offset)
    }
}

struct ValueBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
