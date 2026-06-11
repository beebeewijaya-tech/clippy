//
//  ClippyApp.swift
//  Clippy
//
//  Created by Bee Wijaya on 09/06/26.
//

import SwiftUI
import SwiftData

@main
struct ClippyApp: App {
    let container: ModelContainer
    @State var clipboardViewModel: ClipboardViewModel
    
    init() {
        self.container = try! ModelContainer(for: ClipboardModel.self)
        self._clipboardViewModel = State(initialValue: ClipboardViewModel(modelContext: container.mainContext))
    }
    
    var body: some Scene {
        WindowGroup(id: "main") {
            MainScreen()
                .environment(clipboardViewModel)
                .modelContainer(container)
        }
        
        MenuBarExtra("Clippy", systemImage: "clipboard.fill") {
            MenuBarScreen()
                .environment(clipboardViewModel)
                .modelContainer(container)
        }
        .menuBarExtraStyle(.window)
    }
}
