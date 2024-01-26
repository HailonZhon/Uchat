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
        guard let url = URL(string: "http://127.0.0.1:8080/stream_chat") else {
            print("URL构建失败")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let body: [String: String] = [
            "api_key": "sk-IjqBdKx2iuVNXKRxFbCbE2A9Cd284cE0A2Bd78036e095521",
            "model": "gpt-4",
            "message": message
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        print("请求准备完成，即将发送")
        
        _ = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("请求错误: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("无法获取HTTP响应")
                return
            }
            
            print("收到响应，状态码：\(response.statusCode)")
            
            if response.statusCode != 200 {
                print("服务器返回错误状态码：\(response.statusCode)")
                return
            }
            
            guard let data = data else {
                print("无响应数据")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    completion(responseString)
                    print("收到响应数据：\(responseString)")
                }
            } else {
                print("无法解码响应数据")
            }
        }
    }
    
}
