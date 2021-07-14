//
//  ImageCell.swift
//  Electrolux
//
//  Created by Mehmet Can Seyhan on 2021-07-11.
//

import SwiftUI
import Kingfisher

struct ImageCell: View {
    
    //MARK: - PROPERTIES
    let photo: Photo
    
    //MARK: - BODY
    
    var body: some View {
        
        HStack(spacing: 12) {
            KFImage(URL(string: photo.urlM!))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150)
                .cornerRadius(10)
                .shadow(color: Color.primary.opacity(0.3), radius: 1)
            
        } //HStack
        .animation(.interactiveSpring())
        
    }
}

