//
//  MyApp1App.swift
//  MyApp1
//
//  Created by Okamoto Koichiro on 2025/03/29.
//

import SwiftUI

@main
struct MyApp1App: App {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(nil) // This ensures the app follows the system color scheme
        }
    }
}
