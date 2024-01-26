//
//  Buttons.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//
import SwiftUI
import Foundation
// 顶部导航栏
struct TopBarView: View {
    let action1: () -> Void
    let action2: () -> Void
    let action3: () -> Void
    
    var body: some View {
        HStack {
            Button(action: action1) {
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
                    .frame(minWidth: 44, minHeight: 44)
            }
            .padding(.leading, 20)
            
            Spacer()
            
            Button(action: action2) {
                Text("ChatGPT-4")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
            }
            
            Spacer()
            
            Button(action: action3) {
                Image(systemName: "pencil.tip.crop.circle.badge.plus")
                    .imageScale(.large)
                    .frame(minWidth: 44, minHeight: 44)
            }
            .padding(.trailing, 20)
        }
    }
}

// 底部导航栏
struct BottomBarView: View {
    @Binding var messageText: String
    let actionCamera: () -> Void
    let actionPhoto: () -> Void
    let actionFolder: () -> Void
    let actionAudio: () -> Void
    let actionHeadphones: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            IconButton(iconName: "camera.fill", action: actionCamera)
            IconButton(iconName: "photo.fill.on.rectangle.fill", action: actionPhoto)
            IconButton(iconName: "folder.fill", action: actionFolder)
            
            Spacer()
            
            // 消息输入框
            MessageTextField(messageText: $messageText, actionAudio: actionAudio)

            Spacer()
            
            IconButton(iconName: "headphones", action: actionHeadphones)
        }
    }
}

// 图标按钮
struct IconButton: View {
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .frame(minWidth: 24, minHeight: 24)
        }
    }
}

// 消息输入框
struct MessageTextField: View {
    @Binding var messageText: String
    let actionAudio: () -> Void
    let sendMessage: () -> Void  // 添加的发送消息回调
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            TextField("消息", text: $messageText)
                .padding(10)
                .background(Capsule().fill(Color.white))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .overlay(
                    Capsule().stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 10)

            Button(action: {
                sendMessage()  // 调用发送消息回调
            }){
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .padding(.trailing, 8)
        }
    }
}

