//
//  StreamResponse.swift
//  UChat
//
//  Created by Midnight Maverick on 2024/1/26.
//

import Foundation
func sendMessage(_ message: String, model: String, apiKey: String) async {
    // 构建请求URL和请求体
    let url = URL(string: "http://127.0.0.1:8000/stream_chat")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let body: [String: Any] = ["api_key": apiKey, "model": model, "message": message]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)

    // 发送请求并处理响应
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        // 解析响应数据并更新UI
        // 注意：这里需要解析数据流，具体实现取决于后端发送的数据格式
    } catch {
        print("请求失败: \(error)")
    }
}
