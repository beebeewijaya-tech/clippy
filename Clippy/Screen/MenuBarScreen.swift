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
                ForEach(clipboardList.indices, id: \.self) { id in
                    ClipItem(clipboard: clipboardList[id]) {
                        clipboardViewModel.copyText(at: id, clipboardList)
                    } onDelete: {
                        clipboardViewModel.deleteClipboard(at: id, clipboardList)
                    }
                    .padding(.bottom, 8)
                }
            }
        }
        .padding()
        .frame(width: 300, height: 500)
    }
}

#Preview {
    let container = try! ModelContainer(for: ClipboardModel.self)
    
    MenuBarScreen()
        .environment(ClipboardViewModel(modelContext: container.mainContext))
        .modelContainer(container)
}
