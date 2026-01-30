//
//  colorExtension.swift
//  CTDSwiftUI
//
//  Created by gayatri vohra on 3/20/24.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3:
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (alpha, red, green, blue) = (255, (int >> 16) , (int >> 8 & 0xFF) , (int & 0xFF))
        default:
            (alpha, red, green, blue) = (255, 0,0,0)
        }
        self.init(.sRGB, red: Double(red) / 255, green: Double(green) / 255, blue: Double(blue) / 255 )
    }
    
    static func backgroundColor() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors:[Color(hex: "#87CEEB"), Color(hex:"6BB2CF"),Color(hex: "#003366")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
}



