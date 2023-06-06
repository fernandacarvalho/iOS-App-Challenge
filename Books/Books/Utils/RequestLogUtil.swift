//
//  RequestLogUtil.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 05/06/23.
//

import Foundation

final class RequestLogUtil {
    static func log(request: URLRequest) {
        let requestDate = Date().getDateString()
        if let url = request.url, let method = request.httpMethod {
            print("\(requestDate) --> \(method) \(url)")
        }
        if let headers = request.allHTTPHeaderFields {
            for header in headers {
                let key = header.key
                let value = header.value
                print("\(requestDate)  \(key):\(value)")
            }
        }
        if let requestBody = request.httpBody,
           let json = try? JSONSerialization.jsonObject(with: requestBody, options: []) as? [String: Any] {
            for item in json {
                let key = item.key
                let value = item.value
                print("\(requestDate)  \(key):\(value)")
            }
        }
        print(("\(requestDate)  --> END \(request.httpMethod ?? "REQUEST")"))
    }
    
    static func log(response: HTTPURLResponse, data: Data?) {
        let responseDate = Date().getDateString()
        let statusCode = response.statusCode
        let url = response.url?.absoluteString ?? ""
        print("\(responseDate) <-- \(statusCode) \(url)")
        let headers = response.allHeaderFields
        for header in headers {
            let key = header.key
            let value = header.value
            print("\(responseDate)  \(key):\(value)")
        }
        if let responseBody = data, responseBody.count > 0 {
            if let json = try? JSONSerialization.jsonObject(with: responseBody, options: .allowFragments) as? [String: Any] {
                for dict in json {
                    print("\(responseDate)  \(dict.key) : \(dict.value)")
                }
            } else if let body = String(data: responseBody, encoding: .utf8) {
                print("\(responseDate)  \(body)")
            }
        }
        print("\(responseDate)  <-- END HTTP")
    }
    
    static func log(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
