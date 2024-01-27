//
//  StreamResponse.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//

import Foundation

class ChatService {
    var dataTask: URLSessionDataTask?
    var currentMessageContent: String = ""
    func streamChat(apiKey: String, model: String, message: String, onReceive: @escaping (String, Bool) -> Void) {
        print("准备构建URL")
        guard let url = URL(string: "http://127.0.0.1:8000/stream_chat") else {
            print("URL构建失败")
            return
        }

        print("正在添加查询参数")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "model", value: model),
            URLQueryItem(name: "message", value: message)
        ]

        guard let finalURL = components?.url else {
            print("构建带查询参数的URL失败")
            return
        }

        print("构建HTTP请求")
        var request = URLRequest(url: finalURL)
        request.httpMethod = "POST"
        request.addValue("text/event-stream", forHTTPHeaderField: "Accept")

        print("开始执行数据任务")
        dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                print("请求错误: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("服务器返回非200状态码")
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("接收到流式数据: \(responseString)")
                self.parseSSEData(responseString) { message, isFinal in
                    // 确保 `onReceive` 闭包有两个参数
                    onReceive(message, isFinal)
                }
            }else {
                print("未接收到数据")
            }
        }
        dataTask?.resume()
    }

    private func parseSSEData(_ data: String, onReceive: (String, Bool) -> Void) {
        // 假设服务器发送的每个消息块都以"data: "开头，以"\n\n"结束
        let events = data.components(separatedBy: "\n\n")
        for event in events {
            if event.hasPrefix("data: ") {
                let message = String(event.dropFirst("data: ".count))
                onReceive(message, false)  // 传递 false，表示消息还未结束
            } else if event == "streaming-ended" {
                onReceive("", true)  // 传递 true，表示消息结束
            }
        }
    }

}
