//
//  TransactionTableItemView.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 10/08/2022.
//

import SwiftUI

struct TransactionTableItemView: View {
    
    let transaction: Transaction
    let coinMarketValue: Double
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(transaction.type ? .green : .red)
                .frame(width: 5, height: 30)
                .padding(.leading, -10)
            
            Text(transaction.date.uppercased().prefix(6))
                .font(.system(size: 10))
                .rotationEffect(Angle(degrees: -90))
                .padding(.leading, -20)
            
            Text(String(transaction.volume))
                .padding(.leading, -10)
            Spacer()
            
            Text(String(transaction.price))
                .padding(.leading, -30)
            Spacer()
            
            Text(String(format: "%.2f", countTransactionPercentageChange()))
        }
    }
    
    //MARK: - Functions
    
    private func countTransactionPercentageChange() -> Double {
        if transaction.volume == 0 { return 0 }
        return ((coinMarketValue * 100) / transaction.price) - 100
    }
}

struct TransactionTableItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionTableItemView(transaction: emptyTransaction, coinMarketValue: 0)
    }
}
