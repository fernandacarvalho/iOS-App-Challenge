//
//  UIColor+Extension.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 26/05/23.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    @Theme(light: UIColor(named: "AccentColor") ?? UIColor(hexString: "#FF9500"),
               dark: UIColor(named: "AccentColor") ?? UIColor(hexString: "#FF9500"))
        static var accentColor: UIColor
    
    @Theme(light: UIColor(named: "BackgroundColor") ?? UIColor(hexString: "#ECECEC"),
               dark: UIColor(named: "BackgroundColor") ?? UIColor(hexString: "#2B2B2B"))
        static var backgroundColor: UIColor
    
    @Theme(light: UIColor(named: "ButtonTextColor") ?? UIColor(hexString: "#FFFFFF"),
               dark: UIColor(named: "ButtonTextColor") ?? UIColor(hexString: "#FFFFFF"))
        static var buttonTextColor: UIColor
    
    @Theme(light: UIColor(named: "DisabledColor") ?? UIColor(hexString: "#DCDCDF"),
               dark: UIColor(named: "DisabledColor") ?? UIColor(hexString: "#444444"))
        static var disabledColor: UIColor
    
    @Theme(light: UIColor(named: "PrimaryTextColor") ?? UIColor(hexString: "#000000"),
               dark: UIColor(named: "PrimaryTextColor") ?? UIColor(hexString: "#D3D3D3"))
        static var primaryTextColor: UIColor
    
    @Theme(light: UIColor(named: "SecondaryTextColor") ?? UIColor(hexString: "#878A90"),
               dark: UIColor(named: "SecondaryTextColor") ?? UIColor(hexString: "#878A90"))
        static var secondaryTextColor: UIColor
    
    @Theme(light: UIColor(named: "CardBackgroundColor") ?? UIColor(hexString: "#FFFFFF"),
               dark: UIColor(named: "CardBackgroundColor") ?? UIColor(hexString: "#565656"))
        static var cardBackgroundColor: UIColor
}

@propertyWrapper
struct Theme {
    let light: UIColor
    let dark: UIColor

    var wrappedValue: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return self.dark
                } else {
                    return self.light
                }
            }
        } else {
            return self.light
        }
    }
}
