//
//  Settings.swift
//  CTDSwiftUI
//
//  Created by gayatri vohra on 3/23/24.
//

import Foundation

enum menuOptions: String {
    case Food
    case Medical
    case Shower
    case Shelter
    case Dropin
    case Toilet
    case Clothing
    case Guide
    case Error
    
    static func indexToOption(idx: Int) -> menuOptions {
        if idx == 0 {
            return .Food
        }
        if idx == 1 {
            return .Shelter
        }
        if idx == 2 {
            return .Dropin
        }
        if idx == 3 {
            return .Shower
        }
        if idx == 4 {
            return .Toilet
        }
        if idx == 5 {
            return .Clothing
        }
        if idx == 6 {
            return .Medical
        }
        if idx == 7 {
            return .Guide
        }
        return .Error
    }
}

struct Setting {
    static var option: menuOptions = .Dropin
}

