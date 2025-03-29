//
//  MyApp1App.swift
//  MyApp1
//
//  Created by Okamoto Koichiro on 2025/03/29.
//

import SwiftUI

// MARK: - AppTheme
struct AppTheme {
    // Text colors
    let primaryText: Color
    let secondaryText: Color
    
    // UI Element colors
    let primaryBackground: Color
    let secondaryBackground: Color
    let accentColor: Color
    let buttonBackground: Color
    let formBorder: Color
    
    // Rating colors
    let starFilled: Color
    let starEmpty: Color
    
    // Static themes
    static let light = AppTheme(
        primaryText: .black,
        secondaryText: .gray,
        primaryBackground: .white,
        secondaryBackground: Color(UIColor.systemGray6),
        accentColor: .blue,
        buttonBackground: .blue,
        formBorder: Color.gray.opacity(0.2),
        starFilled: .yellow,
        starEmpty: .gray
    )
    
    static let dark = AppTheme(
        primaryText: .white,
        secondaryText: Color(UIColor.lightGray),
        primaryBackground: Color(UIColor.systemBackground),
        secondaryBackground: Color(UIColor.systemGray6),
        accentColor: .blue,
        buttonBackground: Color.blue.opacity(0.8),
        formBorder: Color.gray.opacity(0.4),
        starFilled: .yellow,
        starEmpty: Color.gray.opacity(0.7)
    )
}

// MARK: - Theme Environment Key
struct ThemeKey: EnvironmentKey {
    static let defaultValue: AppTheme = .light
}

extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

// MARK: - Theme Manager
class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme
    @Published var colorScheme: ColorScheme
    
    init(colorScheme: ColorScheme) {
        self.colorScheme = colorScheme
        self.currentTheme = colorScheme == .dark ? .dark : .light
    }
}

struct ThemeAwareView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var themeManager: ThemeManager
    let content: (ThemeManager) -> Content
    
    init(@ViewBuilder content: @escaping (ThemeManager) -> Content) {
        self._themeManager = StateObject(wrappedValue: ThemeManager(colorScheme: .light))
        self.content = content
    }
    
    var body: some View {
        content(themeManager)
            .onChange(of: colorScheme) { 
                themeManager.colorScheme = colorScheme
                themeManager.currentTheme = colorScheme == .dark ? .dark : .light
            }
            .onAppear {
                // Ensure we start with the correct theme
                themeManager.colorScheme = colorScheme
                themeManager.currentTheme = colorScheme == .dark ? .dark : .light
            }
    }
}

@main
struct MyApp1App: App {
    var body: some Scene {
        WindowGroup {
            ThemeAwareView { themeManager in
                ContentView()
                    .preferredColorScheme(nil) // Follow system color scheme
                    .environmentObject(themeManager)
            }
        }
    }
}
