//
//  login.swift
//  UChat
//
//  Created by hailong on 2024/1/25.
//

import Foundation

func login(requestData: LoginRequest, completion: @escaping (Bool, Error?) -> Void) {
    guard let url = URL(string: "http://192.168.3.21:8000/users/login") else {
        print("Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        request.httpBody = try JSONEncoder().encode(requestData)
    } catch {
        completion(false, error)
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(false, error)
            return
        }

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            completion(false, nil)
            return
        }

        completion(true, nil)
    }.resume()
}

