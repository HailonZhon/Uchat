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
    @State private var currentChatGPTMessage: Message?

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
    // 使用API密钥和模型名称作为参数，根据您的设置来修改这些值

    private func sendMessage() {
        // 用户发送的消息
        let userMessage = Message(id: UUID().uuidString, text: messageText, sender: .user)
        messages.append(userMessage)
        messageText = "" // 清空输入框
        let apiKey = "sk-IjqBdKx2iuVNXKRxFbCbE2A9Cd284cE0A2Bd78036e095521"
        let model = "gpt-4"
        // 初始化或更新正在构建的ChatGPT消息
        let chatGPTMessageId = UUID().uuidString
        currentChatGPTMessage = Message(id: chatGPTMessageId, text: "", sender: .chatGPT)
        
        // 向后端发送消息并处理流式响应
        chatService.streamChat(apiKey: apiKey, model: model, message: userMessage.text) { [self] (responseText, isFinal) in
            DispatchQueue.main.async {
                // 累积构建ChatGPT的回复消息
                self.currentChatGPTMessage?.text += responseText
                
                
                if isFinal {
                    // 如果是最后一部分消息，则添加到消息列表中，并重置当前ChatGPT消息
                    if let completedMessage = self.currentChatGPTMessage {
                        self.messages.append(completedMessage)
                        print("添加新消息: \(completedMessage.text)")
                        self.currentChatGPTMessage = nil
                    }
                } else if self.currentChatGPTMessage == nil {
                    // 如果流式消息还在进行中，但当前消息为空，则初始化它
                    self.currentChatGPTMessage = Message(id: chatGPTMessageId, text: responseText, sender: .chatGPT)
                    
                }
            }
        }
    }


}




#Preview {
    MainPageButtonView()
}
