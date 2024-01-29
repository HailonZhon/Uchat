//
//  MainPageButtonView.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//        let apiKey = "sk-IjqBdKx2iuVNXKRxFbCbE2A9Cd284cE0A2Bd78036e095521"

import SwiftUI

struct MainPageButtonView: View {
    @State private var messageText: String = ""
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var chatViewModel = ChatViewModel()

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

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(chatViewModel.messages, id: \.id) { message in
                        MessageView(message: message)
                    }
                }
            }

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
                },
                actionHeadphones: {
                    // 输入框为空时的耳机动作
                }
            )
            .padding(.horizontal)
        }
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}

#Preview {
    MainPageButtonView()
}
