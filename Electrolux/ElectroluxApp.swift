//
//  ElectroluxApp.swift
//  Electrolux
//
//  Created by Mehmet Can Seyhan on 2021-07-11.
//

import SwiftUI

@main
struct ElectroluxApp: App {
    
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(PhotoViewModel.shared)
        }
    }
}
