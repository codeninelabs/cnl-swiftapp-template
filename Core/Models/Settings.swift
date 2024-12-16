//
//  SettingsModel.swift
//  <project_name>
//
//  Created by Kevin Armstrong on 12/5/24.
//


import Foundation
import SwiftUI

class Settings: ObservableObject {
    static let shared = Settings()
    let userDefaults = UserDefaults.standard

    @Published var themeMode: ThemeMode = AppConfig.defaultThemeMode
    @Published var themeColor: Color = AppConfig.defaultThemeColor

    private init() {
        // Register default values for theme mode and theme color
        userDefaults.register(defaults: [
            AppConfig.keyThemeMode: AppConfig.defaultThemeMode.rawValue,
            AppConfig.keyThemeColor: AppConfig.defaultThemeColor
        ])
        
        // RESET USER DEFAULTS DURING DEVELOPMENT
//        userDefaults.removeObject(forKey: AppConfig.keyThemeColor)
        
        // Initialize settings
        loadThemeMode()
        loadThemeColor()
    }
    
    // MARK: - Theme Management
    func setThemeMode(mode: ThemeMode) {
        themeMode = mode
        userDefaults.set(mode.rawValue, forKey: AppConfig.keyThemeMode)
    }
    
    func setThemeColor(color: Color) {
        themeColor = color
        userDefaults.set(color.toHexString(), forKey: AppConfig.keyThemeColor)
    }
    
    // MARK: - Private Helpers
    private func loadThemeMode() {
        if let themeModeRaw = userDefaults.string(forKey: AppConfig.keyThemeMode) {
            themeMode = ThemeMode(rawValue: themeModeRaw) ?? AppConfig.defaultThemeMode
        }
    }
    
    private func loadThemeColor() {
        if let themeColorHex = userDefaults.string(forKey: AppConfig.keyThemeColor) {
            themeColor = Color(hex: themeColorHex) ?? AppConfig.defaultThemeColor
        }
    }
}
