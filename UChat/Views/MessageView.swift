//
//  MessageView.swift
//  UChat
//
//  Created by hailong on 2024/1/27.
//
import SwiftUI
struct MessageView: View {
    let message: Message

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: message.sender == .user ? "heart" : "heart.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.trailing, 1)
                .padding(.leading, 20)

            VStack(alignment: .leading) {
                Text(message.sender == .user ? "USER" : "ChatGPT")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(message.text)
            }

            Spacer()
        }
    }
}

