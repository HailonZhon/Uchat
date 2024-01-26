//
//  model.swift
//  UChat
//
//  Created by hailong on 2024/1/25.
//

import Foundation
struct LoginRequest: Codable {
    var login: String
    var password: String
    var verification_code: String
}
//struct ChatMessage: Identifiable {
//    let id = UUID()
//    let username: String
//    let text: String
//}
