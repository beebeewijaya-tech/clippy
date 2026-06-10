//
//  MainScreen.swift
//  Clippy
//
//  Created by Bee Wijaya on 09/06/26.
//

import SwiftUI


struct ClipList: View {
    var body: some View {
        VStack {
            Text("Hello world")
        }
    }
}

struct MainScreen: View {
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<5) { _ in
                    ClipList()
                }
            }
        }
        .padding()
    }
}

#Preview {
    MainScreen()
}
