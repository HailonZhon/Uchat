//
//  Message.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//

import Foundation
// 定义一个 ObservableObject 类来管理消息
class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = [
        Message(id: UUID().uuidString, text: "测试消息", sender: .chatGPT), //测试数据
        Message(id: UUID().uuidString, text: "测试消息", sender: .chatGPT) //测试数据
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
