//
//  StreamResponse.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//

import Foundation

import Combine

class ChatService {
    var cancellables: Set<AnyCancellable> = []

    func sendMessage(_ message: String, completion: @escaping (String) -> Void) {
            guard let url = URL(string: "http://127.0.0.1:8080/stream_chat") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            let body: [String: String] = [
                "api_key": "sk-IjqBdKx2iuVNXKRxFbCbE2A9Cd284cE0A2Bd78036e095521",
                "model": "gpt-4",
                "message": message
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

            // 创建一个 URLSessionDataTask 来处理流式响应
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let _self = self, let data = data else { return }

                // 直接将接收到的文本数据转换为字符串
                if let responseString = String(data: data, encoding: .utf8) {
                    
                    DispatchQueue.main.async {
                        completion(responseString)
                        print(responseString)
                    }
                }
            }

            task.resume()
        }
}
