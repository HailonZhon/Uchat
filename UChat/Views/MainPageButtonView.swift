//
//  MainPageButtonView.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//

import SwiftUI

struct MainPageButtonView: View {
    @State private var messageText: String = ""
    @State private var chatMessages: [ChatMessage] = []
    @Environment(\.colorScheme) var colorScheme
    
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
            ChatView(messages: $chatMessages)
            Spacer() // 这个 Spacer 会推动下面的内容到底部
            
            BottomBarView(messageText: $messageText, actionCamera: {
                // 执行相机动作
            }, actionPhoto: {
                // 执行照片动作
            }, actionFolder: {
                // 执行文件夹动作
            }, actionAudio: {
                // 执行音频动作
            }, actionHeadphones: {
                // 执行耳机动作
            })
            .padding(.horizontal)
        }
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}


#Preview {
    MainPageButtonView()
}
