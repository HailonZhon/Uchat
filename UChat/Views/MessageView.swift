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
            HStack(alignment: .top) {
                Image(systemName: message.sender == .user ? "heart" : "heart.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 8)

                VStack(alignment: .leading) {
                    Text(message.sender == .user ? "USER" : "ChatGPT")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(message.text)
                }

                Spacer()
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
    }
}

