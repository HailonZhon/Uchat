//
//  Message.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//

import Foundation
struct Message: Identifiable, Decodable {
    let id: String
    var text: String
    var sender: Sender

    enum Sender: String, Decodable {
        case user = "USER"
        case chatGPT = "CHATGPT"
    }

    mutating func updateText(newText: String) {
        self.text = newText
    }
}
