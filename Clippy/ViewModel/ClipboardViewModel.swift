//
//  ClipboardViewModel.swift
//  Clippy
//
//  Created by Bee Wijaya on 10/06/26.
//

import SwiftUI
import AppKit
import SwiftData

@Observable
@MainActor
final class ClipboardViewModel {
    private var lastChangedCount = NSPasteboard.general.changeCount
    private var monitoringTask: Task<Void, Never>?
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        startMonitoring()
        startCleaning()
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
                        self.modelContext.insert(ClipboardModel(text: text.trimmingCharacters(in: .whitespaces), isPin: false))
                        let descriptor = FetchDescriptor<ClipboardModel>(
                            predicate: #Predicate { !$0.isPin },
                            sortBy: [SortDescriptor(\.created, order: .reverse)]
                        )
                        if let all = try? modelContext.fetch(descriptor), all.count > 150 {
                            all.suffix(from: 150).forEach { modelContext.delete($0) }
                        }
                        try? modelContext.save()
                    }
                }
            }
        }
    }
    
    
    func stopMonitoring() {
        monitoringTask?.cancel()
        monitoringTask = nil
    }
    
    func deleteClipboard(at index: Int, _ clipboardList: [ClipboardModel]) {
        let copy = clipboardList[index]
        if let text = NSPasteboard.general.string(forType: .string) {
            if text == copy.text {
                NSPasteboard.general.clearContents()
            }
        }
        modelContext.delete(copy)
        try? modelContext.save()
    }
    
    func copyText(at index: Int, _ clipboardList: [ClipboardModel]) {
        let copy = clipboardList[index]
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(copy.text, forType: .string)
    }
    
    
    func clearExpiredClipboard() {
        let cutoff = Date.now.addingTimeInterval(-(24 * 60 * 60))
        let descriptor = FetchDescriptor<ClipboardModel>(
            predicate: #Predicate { $0.created < cutoff }
        )
        
        if let expired = try? modelContext.fetch(descriptor) {
            expired.forEach {
                modelContext.delete($0)
            }
            
            try? modelContext.save()
        }
    }
    
    func startCleaning() {
        Task {
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(3600))
                clearExpiredClipboard()
            }
        }
    }
    
    func pinClipboard(at index: Int, _ clipboardList: [ClipboardModel]) {
        let copy = clipboardList[index]
        copy.isPin.toggle()
        try? modelContext.save()
    }
}
