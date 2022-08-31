//
//  SearchBarView.swift
//  CoinMemo
//
//  Created by Jędrzej Kuś on 26/07/2022.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
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
                    withAnimation {
                        isSearching = false
                    }
                }
                
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
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("Something"), isSearching: .constant(false))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
