//
//  MainScreen.swift
//  Clippy
//
//  Created by Bee Wijaya on 09/06/26.
//

import SwiftUI

struct MainScreen: View {
    private var clipped = [
        "Hello World",
        "@user",
        "https://google.com",
        "1234567890",
        "+628123456789"
    ]
    
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
                ForEach(clipped.indices, id: \.self) { id in
                    ClipItem(label: clipped[id]) {
                        
                    } onDelete: {
                        
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
