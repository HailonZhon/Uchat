//
//  MessageView.swift
//  UChat
//
//  Created by hailong on 2024/1/27.
//
import SwiftUI
struct MessagesView: View {
    var messages: [Message]

    var body: some View {
        List(messages) { message in
            HStack(alignment: .top) { // 确保头像和文本在顶部对齐
                Image(systemName: "person.circle") // 使用系统图标作为临时头像
                    .resizable()
                    .frame(width: 25, height: 25) // 设置头像的大小
                    .padding(.trailing, 8) // 在头像和文本之间添加一些空间
                
                VStack(alignment: .leading) { // 左对齐的垂直堆叠
                    Text("USER") // 显示用户名
                        .font(.headline) // 可以调整字体样式
                        .foregroundColor(.secondary) // 用户名的颜色
                    Text(message.text) // 真正的对话内容
                }

                Spacer()
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
    }
}
