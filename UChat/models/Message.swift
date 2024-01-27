//
//  Message.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//

import Foundation
//struct Message: Identifiable, Decodable {
//    let id: String
//    var text: String
//    var sender: Sender
//
//    enum Sender: String, Decodable {
//        case user = "USER"
//        case chatGPT = "CHATGPT"
//    }
//
//    mutating func updateText(newText: String) {
//        self.text = newText
//    }
//}
// 定义一个 ObservableObject 类来管理消息
class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = [
        Message(id: UUID().uuidString, text: "测试消息", sender: .chatGPT) // 测试数据
    ]
}

// 消息结构体
struct Message: Identifiable, Decodable {
    let id: String
    let text: String
    let sender: Sender
}

// 发送者枚举
enum Sender: String, Decodable {
    case user = "user"
    case chatGPT = "chatGPT"
}
