//
//  LoginPage.swift
//  UChat
//
//  Created by hailong on 2024/1/24.
//


import SwiftUI

struct LoginPage: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var keyboardHeight: CGFloat = 0
    @State private var verificationCode: String = ""
    @State private var showingLoginSuccessPopup = false
    var body: some View {
        NavigationView {
            
            VStack {
                Spacer(minLength:350) // 用于在顶部留出空间

                // 用户图标
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color(.systemBlue))
                    .padding(.bottom, 20)

                // 使用抽象的输入框组件
                TextInputField(title: "账号", text: $username)
                PasswordInputField(title: "密码", text: $password)
                // 注册和忘记密码按钮
                HStack {
                    Spacer()
                    Button(action: {
                        // 处理忘记密码逻辑
                    }) {
                        Text("忘记密码？")
                            .font(.subheadline)
                            .foregroundColor(Color.blue)
                    }
                }
                // 登录按钮
                PrimaryButton(title: "登录", action: {
                    // 登录逻辑
                    performLogin()
                })

                Spacer(minLength: 45) // 在底部也添加一个Spacer
                // 注册按钮
                Button(action: {
                    // 处理注册逻辑
                }) {
                    Text("注册新账号")
                        .font(.subheadline)
                        .foregroundColor(Color.blue)
                }.padding(.bottom, 20) // 为按钮添加一些底部外边距
                Spacer(minLength: 450)
            }
            .padding()
            .offset(y: -keyboardHeight / 200000)
            .onAppear(perform: setupKeyboardListeners)
            .navigationTitle("深斯AI")
            // 弹窗动画
//            if showingLoginSuccessPopup {
//                LoginSuccessPopup(isShowing: $showingLoginSuccessPopup)
//            }


        }
    }
    private func performLogin() {
        let loginRequest = LoginRequest(login: username, password: password, verification_code: verificationCode)
        login(requestData: loginRequest) { success, error in
            if success {
                print("登录成功，即将显示弹窗1")
                DispatchQueue.main.async {
                    print("登录成功，即将显示弹窗2")
                    self.showingLoginSuccessPopup = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showingLoginSuccessPopup = false
                        // 登录成功后的其他操作
                    }
                }
            } else {
                print("登录失败: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    private func setupKeyboardListeners() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            let keyboardFrame = value?.cgRectValue
            keyboardHeight = keyboardFrame?.height ?? 0
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            keyboardHeight = 0
        }
    }
}

struct TextInputField: View {
    var title: String
    @Binding var text: String

    var body: some View {
        TextField(title, text: $text)
            .padding()
            .background(Color.secondary.opacity(0.3))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct PasswordInputField: View {
    var title: String
    @Binding var text: String

    var body: some View {
        SecureField(title, text: $text)
            .padding()
            .background(Color.secondary.opacity(0.3))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct PrimaryButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(15.0)
        }
    }
}

struct LoginSuccessPopup: View {
    @Binding var isShowing: Bool

    var body: some View {
        if isShowing {
            ZStack {
                // 半透明背景
                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)

                // 弹窗内容
                VStack(spacing: 20) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.green)
                    
                    Text("登录成功")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding(40)
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .shadow(radius: 20)
                .scaleEffect(isShowing ? 1 : 0.5)
                .opacity(isShowing ? 1 : 0)
                .animation(.easeInOut, value: isShowing)
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

