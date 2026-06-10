//
//  ClipboardViewModel.swift
//  Clippy
//
//  Created by Bee Wijaya on 10/06/26.
//

import SwiftUI
import AppKit


@Observable
@MainActor
final class ClipboardViewModel {
    var clipboards: [String] = []
    
    private var lastChangedCount = NSPasteboard.general.changeCount
    private var monitoringTask: Task<Void, Never>?
    
    init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        monitoringTask?.cancel()
        monitoringTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(0.5))
                let current = NSPasteboard.general.changeCount
                if current != self.lastChangedCount {
                    self.lastChangedCount = current
                    if let text = NSPasteboard.general.string(forType: .string) {
                        self.clipboards.insert(text.trimmingCharacters(in: .whitespaces), at: 0)
                    }
                }
            }
        }
    }
    
    
    func stopMonitoring() {
        monitoringTask?.cancel()
        monitoringTask = nil
    }
    
    func deleteClipboard(at index: Int) {
        let copy = clipboards[index]
        
        if let text = NSPasteboard.general.string(forType: .string) {
            if text == copy {
                NSPasteboard.general.clearContents()
            }
        }
        
        clipboards.remove(at: index)
    }
    
    func copyText(at index: Int) {
        let copy = clipboards[index]
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(copy, forType: .string)
    }
}
