//
//  ClipItem.swift
//  Clippy
//
//  Created by Bee Wijaya on 10/06/26.
//

import SwiftUI


struct ClipItem: View {
    var clipboard: ClipboardModel
    var onCopy: () -> Void
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    Text(clipboard.text)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 8)
                    
                    Text(clipboard.created, format: .dateTime)
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
                
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
        .background {
            if #available(macOS 26, *) {
                Color.clear.glassEffect(in: .rect(cornerRadius: 12))
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)
            }
        }
    }
}
