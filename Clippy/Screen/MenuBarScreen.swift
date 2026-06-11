//
//  MainScreen.swift
//  Clippy
//
//  Created by Bee Wijaya on 09/06/26.
//

import SwiftUI
import SwiftData

struct MenuBarScreen: View {
    // MARK: - Environment
    @Environment(ClipboardViewModel.self) private var clipboardViewModel
    @Environment(\.modelContext) private var modelContext
    
    
    // MARK: - Query
    @Query(sort: \ClipboardModel.created, order: .reverse) private var clipboardList: [ClipboardModel]
    var sortedClipboard: [ClipboardModel] {
        clipboardList.sorted { $0.isPin && !$1.isPin }
    }
    
    var body: some View {
        VStack {
            Text("Clippy")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Text("Your clipboard, remembered")
                .font(.caption)
                .foregroundStyle(.white)
                .padding(.bottom, 12)
            
            ScrollView {
                ForEach(sortedClipboard.indices, id: \.self) { id in
                    ClipItem(clipboard: sortedClipboard[id]) {
                        clipboardViewModel.copyText(at: id, sortedClipboard)
                    } onDelete: {
                        clipboardViewModel.deleteClipboard(at: id, sortedClipboard)
                    } onPin: {
                        clipboardViewModel.pinClipboard(at: id, sortedClipboard)
                    }
                    .padding(.bottom, 8)
                }
            }
        }
        .padding()
        .frame(width: 450, height: 500)
    }
}

#Preview {
    let container = try! ModelContainer(for: ClipboardModel.self)
    
    MenuBarScreen()
        .environment(ClipboardViewModel(modelContext: container.mainContext))
        .modelContainer(container)
}
