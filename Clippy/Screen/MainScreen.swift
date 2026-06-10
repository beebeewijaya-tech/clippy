//
//  MainScreen.swift
//  Clippy
//
//  Created by Bee Wijaya on 09/06/26.
//

import SwiftUI

struct MainScreen: View {
    @State var clipboardViewModel: ClipboardViewModel = ClipboardViewModel()
    
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
                ForEach(clipboardViewModel.clipboards.indices, id: \.self) { id in
                    ClipItem(label: clipboardViewModel.clipboards[id]) {
                        clipboardViewModel.copyText(at: id)
                    } onDelete: {
                        clipboardViewModel.deleteClipboard(at: id)
                    }
                }
            }
        }
        .padding()
        .frame(width: 300, height: 500)
    }
}

#Preview {
    MainScreen()
}
