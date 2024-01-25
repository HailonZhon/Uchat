//
//  LoginPage.swift
//  UChat
//
//  Created by hailong on 2024/1/24.
//

import SwiftUI

struct LoginPages: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var keyboardHeight: CGFloat = 0
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength:250) // 用于在顶部留出空间
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipped()
                    .padding(.bottom, 20)
                
                TextField("账号", text: $username)
                    .padding()
                    .background(Color.secondary.opacity(0.3))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SecureField("密码", text: $password)
                    .padding()
                    .background(Color.secondary.opacity(0.3))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                Button(action: {
                    // 处理登录逻辑
                }) {
                    Text("登录")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
                
                Spacer(minLength: 350) // 在底部也添加一个Spacer
            }
            .padding()
            .offset(y: -keyboardHeight / 30) // 根据键盘高度调整偏移
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
                    let keyboardFrame = value?.cgRectValue
                    keyboardHeight = keyboardFrame?.height ?? 0
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    keyboardHeight = 0
                }
            }
            .navigationTitle("深斯写作助手")
        }
    }
}


