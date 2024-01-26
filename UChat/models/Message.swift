//
//  Message.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//

import Foundation
struct Message: Decodable, Identifiable {
    let id: String
    var text: String
    var isSending: Bool = false

    // 添加一个更新文本的方法
    mutating func updateText(newText: String) {
        self.text = newText
    }
}

enum Sender: String {
    case user = "USER"
    case chatGPT = "ChatGPT"
}
