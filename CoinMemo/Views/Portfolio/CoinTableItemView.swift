//
//  CoinTableItemView.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 07/08/2022.
//

import SwiftUI

struct CoinTableItemView: View {
    
    let coin: String
    let marketValue: Double
    let volume: Double
    
    var body: some View {
        HStack {
            Text(coin)
                .font(.headline)
            Spacer()
            
            Text(currency+(String(format: "%.2f", marketValue)))
                .font(.headline)
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(currency+String(format: "%.1f", marketValue * volume))
                    .font(.headline)
                
                Text(String(format: "%.3f", volume))
                    .padding(.leading, 30)
                    .font(.footnote)
            }
        }
    }
}

struct CoinTableItemView_Previews: PreviewProvider {
    static var previews: some View {
        CoinTableItemView(coin: "BTC", marketValue: 23000, volume: 0.5)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .padding()
    }
}
