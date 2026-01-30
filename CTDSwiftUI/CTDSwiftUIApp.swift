//
//  CTDSwiftUIApp.swift
//  CTDSwiftUI
//
//  Edited by Seonwoo Choi 1/30/26.
//

import SwiftUI

@main
struct CTDSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale.init(identifier:"en"))
        }
    }
}
