//
//  Settings.swift
//  CTDSwiftUI
//
//  Edited by Seonwoo Choi 1/30/26.
//

import Foundation

struct Options: Identifiable {
    var id = UUID()
    var options: [menuOptions] = [.Food, .Medical]
}

enum menuOptions: String, CaseIterable, Comparable {
    static func < (lhs: menuOptions, rhs: menuOptions) -> Bool {
        return true
    }
    
    
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


