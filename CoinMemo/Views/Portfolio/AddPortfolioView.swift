//
//  AddPortfolioView.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 19/09/2022.
//

import SwiftUI

struct AddPortfolioView: View {
    
    @EnvironmentObject var portfolioDataManager: PortfolioDataManager
    @State private var name = ""
    @State private var colorSelected = colorPicker[0]
    private var gridItem: [GridItem] {
        Array(repeating: .init(.fixed(60)) , count: 3)
    }
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Portfolio")
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
                
                TextField("", text: $name)
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
                    let newPortfolio = Portfolio(id: portfolioDataManager.portfolioArray.count+1, name: name, account_value: 0, badge_color: colorSelected, refresh_date: "", coin: [emptyCoin])
                    portfolioDataManager.portfolioArray.append(newPortfolio)
                }
                portfolioDataManager.savePortfolioToFile()
                isPresented = false
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

struct AddPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        AddPortfolioView(isPresented: .constant(true))
            .preferredColorScheme(.dark)
    }
}
