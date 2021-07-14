//
//  SearchBar.swift
//  Electrolux
//
//  Created by Mehmet Can Seyhan on 2021-07-11.
//

import SwiftUI

struct SearchBar: View {
    
    // MARK: - PROPERTIES
    @Binding var text: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
        } //HStack
        .padding(.horizontal, 10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search..."))
    }
}
