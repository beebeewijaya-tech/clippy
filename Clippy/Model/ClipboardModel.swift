//
//  ClipboardModel.swift
//  Clippy
//
//  Created by Bee Wijaya on 10/06/26.
//

import SwiftUI
import SwiftData

@Model
class ClipboardModel {
    var text: String
    var created: Date
    
    init(text: String) {
        self.text = text
        self.created = .now
    }
}
