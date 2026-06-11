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
    var isPin: Bool
    
    init(text: String, isPin: Bool) {
        self.text = text
        self.created = .now
        self.isPin = isPin
    }
}
