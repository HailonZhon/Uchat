//
//  Message.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//

import Foundation
struct Message: Identifiable {
    let id = UUID()
    let sender: String
    let content: String
}

enum Sender: String {
    case user = "USER"
    case chatGPT = "ChatGPT"
}
