//
//  ProgressViewIndicator.swift
//  Electrolux
//
//  Created by Mehmet Can Seyhan on 2021-07-12.
//

import SwiftUI

struct ProgressViewIndicator: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .scaleEffect(2)
    }
}

struct ProgressViewIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewIndicator()
    }
}
