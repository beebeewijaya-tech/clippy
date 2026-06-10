//
//  ClipItem.swift
//  Clippy
//
//  Created by Bee Wijaya on 10/06/26.
//

import SwiftUI


struct ClipItem: View {
    var label: String
    var onCopy: () -> Void
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Button {
                        onDelete()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Button {
                        onCopy()
                    } label: {
                        Image(systemName: "document.on.document.fill")
                            .foregroundStyle(.white)
                            .font(.caption)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .glassEffect(in: .rect(cornerRadius: 8))
    }
}
