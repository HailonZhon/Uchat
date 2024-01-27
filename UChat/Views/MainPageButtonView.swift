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
        // 用户发送的消息
        let userMessage = Message(id: UUID().uuidString, text: messageText, sender: .user)
        messages.append(userMessage)
        messageText = "" // 清空输入框

        // 向后端发送消息并处理响应
        chatService.sendMessage(userMessage.text) { responseText in
            // ChatGPT的回复
            let chatGPTMessage = Message(id: UUID().uuidString, text: responseText, sender: .chatGPT)
            messages.append(chatGPTMessage)
        }
    }
}




#Preview {
    MainPageButtonView()
}
