//
//  ClippyApp.swift
//  Clippy
//
//  Created by Bee Wijaya on 09/06/26.
//

import SwiftUI

@main
struct ClippyApp: App {
    var body: some Scene {
        MenuBarExtra("Clippy", systemImage: "clipboard.fill") {
            MainScreen()
        }
        .menuBarExtraStyle(.window)
    }
}
