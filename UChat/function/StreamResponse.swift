//
//  StreamResponse.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//

import Foundation

import Combine
import LDSwiftEventSource
class ChatService {
    var cancellables: Set<AnyCancellable> = []
    
    func sendMessage(_ message: String, completion: @escaping (String) -> Void) {
        // 构造带有查询参数的URL
        var components = URLComponents(string: "http://127.0.0.1:8000/stream_chat")
        let queryItems = [
            URLQueryItem(name: "api_key", value: "sk-IjqBdKx2iuVNXKRxFbCbE2A9Cd284cE0A2Bd78036e095521"),
            URLQueryItem(name: "model", value: "gpt-4"),
            URLQueryItem(name: "message", value: message)
        ]
        components?.queryItems = queryItems

        guard let url = components?.url else {
            print("URL构建失败")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        printRequestDetails(request: request)
        URLSession.shared.dataTask(with: request) { data, response, error in
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
        }.resume()
    }
    
}
private func printRequestDetails(request: URLRequest) {
    print("请求URL: \(request.url?.absoluteString ?? "无URL")")
    print("请求方法: \(request.httpMethod ?? "无方法")")
    print("请求头部: \(request.allHTTPHeaderFields ?? [:])")
}
