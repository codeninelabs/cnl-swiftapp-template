//
//  ColorExt.swift
//  <project_name>
//
//  Created by Kevin Armstrong on 12/5/24.
//


import Foundation
import SwiftUI

extension Color {
    // Initialize Color from a hex string
    init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.hasPrefix("#") ? String(hexString.dropFirst()) : hexString
        
        guard hexString.count == 6 else { return nil }
        
        let scanner = Scanner(string: hexString)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            let red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
            let green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
            let blue = CGFloat(hexNumber & 0x0000FF) / 255
            
            self.init(.sRGB, red: Double(red), green: Double(green), blue: Double(blue), opacity: 1.0)
        } else {
            return nil
        }
    }
    
    // Convert Color to hex string
    func toHexString() -> String? {
        guard let components = self.cgColor?.components, components.count >= 3 else {
            return nil
        }
        
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        
        let rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255)
        return String(format: "#%06x", rgb)
    }
    
    func toUIColor() -> UIColor? {
        let components = self.cgColor?.components
        let colorSpace = self.cgColor?.colorSpace
        
        guard let components = components, let colorSpace = colorSpace else {
            return nil
        }
        
        switch colorSpace.model {
        case .monochrome:
            return UIColor(white: components[0], alpha: components[1])
        case .rgb:
            return UIColor(red: components[0], green: components[1], blue: components[2], alpha: components[3])
        default:
            return nil
        }
    }
    
    // Calculate the relative luminance of the color
    private func relativeLuminance() -> Double {
        let components = self.cgColor?.components ?? [0, 0, 0, 1]
        let r = components[0]
        let g = components[1]
        let b = components[2]

        func adjust(_ value: CGFloat) -> Double {
            return (value < 0.03928) ? Double(value) / 12.92 : pow((Double(value) + 0.055) / 1.055, 2.4)
        }

        return 0.2126 * adjust(r) + 0.7152 * adjust(g) + 0.0722 * adjust(b)
    }

    // Determine the best foreground color (white or black) based on the background color
    func bestForegroundColor() -> Color {
        return self.relativeLuminance() > 0.5 ? .black : .white
    }
}
