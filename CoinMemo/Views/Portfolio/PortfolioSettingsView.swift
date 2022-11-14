//
//  PortfolioSettingsView.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 26/07/2022.
//

import SwiftUI

struct PortfolioSettingsView: View {
    
    @EnvironmentObject var portfolioDataManager: PortfolioDataManager
    @State private var name = ""
    @State var colorSelected: BadgeColor
    private var gridItem: [GridItem] {
        Array(repeating: .init(.fixed(60)) , count: 3)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Portfolio Settings")
                    .font(.title)
                Spacer()
            }
            .padding(.bottom, 30)
            
            HStack {
                Text("Set name")
                Spacer()
            }
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                
                TextField(portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].name, text: $name)
                    .disableAutocorrection(true)
                    .padding([.leading, .trailing], 10)
            }
            .frame(height: 40)
            .cornerRadius(10)
            .padding(.bottom, 20)
            
            HStack{
                Text("Set color")
                Spacer()
            }
            
            //Colorpicker
            LazyVGrid(columns: gridItem, spacing: 5) {
                ForEach((0...colorPicker.count-1), id: \.self) { index in
                    
                    Circle()
                        .strokeBorder(colorPicker[index] == colorSelected ? Color.white.opacity(0.5) : Color.clear, lineWidth: 3)
                        .background(Circle().foregroundColor(Color(red: colorPicker[index].red, green: colorPicker[index].green, blue: colorPicker[index].blue)))
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            colorSelected = colorPicker[index]
                        }
                        .scaleEffect(colorPicker[index] == colorSelected ? 0.9 : 1.0)
                }
            }
            
            Button("Save", action: {
                UIApplication.shared.dismissKeyboard()
                if !name.isEmpty {
                    portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].name = name
                }
                portfolioDataManager.portfolioArray[portfolioDataManager.selectedPortfolio].badge_color = colorSelected
                portfolioDataManager.savePortfolioToFile()
            })
            .frame(width: 130, height: 30, alignment: .center)
            .cornerRadius(5)
            .padding(.top, 30)
            .foregroundColor(.accentColor)
            
            Spacer()
        } //: VSTACK
        .padding()
    }
}

struct PortfolioSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioSettingsView(colorSelected: MockData.emptyColorSelected)
            .preferredColorScheme(.dark)
    }
}
