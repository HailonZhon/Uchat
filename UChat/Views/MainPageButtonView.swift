//
//  MainPageButtonView.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//

import SwiftUI

struct MainPageButtonView: View {
    @State private var messageText: String = ""
    @Environment(\.colorScheme) var colorScheme
    @State private var messages: [Message] = [] // 用于存储消息的数组
    
    var body: some View {
        VStack {
            TopBarView(action1: {
                // 执行汉堡菜单的动作
            }, action2: {
                // 执行标题的动作
            }, action3: {
                // 执行铅笔图标的动作
            })
            .padding(.vertical, 10)

            MessagesView(messages: messages) // 显示消息列表

            Spacer() // 将内容推到底部

            // 底部导航栏
            BottomBarView(
                messageText: $messageText,
                actionCamera: {
                    // 相机动作
                },
                actionPhoto: {
                    // 照片动作
                },
                actionFolder: {
                    // 文件夹动作
                },
                actionAudio: {
                    // 输入框为空时的音频动作
                },
                actionSendMessage: {
                    sendMessage()
                },
                actionHeadphones: {
                    // 输入框为空时的耳机动作
                }
            )
            .padding(.horizontal)
        }
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
    private let chatService = ChatService()
    
    private func sendMessage() {
        // 1. 创建一个临时消息并显示在界面上
        var tempMessage = Message(id: UUID().uuidString, text: messageText, isSending: true)
        print("正在给前端发送消息")
        messages.append(tempMessage)
        messageText = "" // 清空输入框
        
        // 向后端发送消息并处理响应
            chatService.sendMessage(tempMessage.text) { responseText in
                if let index = messages.firstIndex(where: { $0.id == tempMessage.id }) {
                    print("正在给后端发送消息")
                    // 更新消息文本
                    tempMessage.updateText(newText: responseText)
                    messages[index] = tempMessage
                }
            }
    }
}




#Preview {
    MainPageButtonView()
}
