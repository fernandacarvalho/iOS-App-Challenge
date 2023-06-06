//
//  MainService.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 31/05/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case noInternetConnection(message: String = "It looks like you're offline. Please check your internet connection and try again.")
    case requestTimeout(message: String = "Sorry, it seems that the request took too long to complete. Please check your internet connection and try again.")
    case unauthorized(message: String = " It seems you are not authorized to access this resource. Please ensure you have the correct credentials and try again.")
    case badRequest(message: String = "Something unexpected happened while processing your request. We apologize for the inconvenience.")
    case serverError(message: String = "We encountered an issue on our server while processing your request. We apologize for the inconvenience.")
    case unknownError(message: String = "We encountered an issue while processing your request. Please try again later.")
}

protocol NetworkErrorProtocol: Error {
    var message: String { get }
}

extension NetworkError: NetworkErrorProtocol {
    var message: String {
        switch self {
        case .noInternetConnection(let message):
            return message
        case .requestTimeout(let message):
            return message
        case .unauthorized(let message):
            return message
        case .badRequest(let message):
            return message
        case .serverError(let message):
            return message
        case .unknownError(let message):
            return message
        }
    }
}

class MainService {
    
    func sendRequest<T: Codable, E: NetworkErrorProtocol>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: Data? = nil,
        timeoutInterval: TimeInterval = 30,
        completion: @escaping (Result<T, E>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.timeoutInterval = timeoutInterval
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        RequestLogUtil.log(request: request)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    RequestLogUtil.log(response: httpResponse, data: data)
                }
                if let err = error {
                    RequestLogUtil.log(error: err)
                    if let urlError = err as? URLError {
                        switch urlError.code {
                        case .notConnectedToInternet:
                            completion(.failure(NetworkError.noInternetConnection() as! E))
                        case .timedOut:
                            completion(.failure(NetworkError.requestTimeout() as! E))
                        default:
                            completion(.failure(NetworkError.unknownError() as! E))
                        }
                    } else {
                        completion(.failure(NetworkError.unknownError(message: err.localizedDescription) as! E))
                    }
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.unknownError() as! E))
                    return
                }
                
                let statusCode = httpResponse.statusCode
                switch statusCode {
                case 200..<300:
                    guard let data = data else {
                        completion(.failure(NetworkError.unknownError() as! E))
                        return
                    }
                    
                    do {
                        let decodedObject = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedObject))
                    } catch {
                        completion(.failure(NetworkError.unknownError() as! E))
                    }
                    
                case 400..<500:
                    completion(.failure(NetworkError.badRequest() as! E))
                    
                case 500..<600:
                    completion(.failure(NetworkError.serverError() as! E))
                    
                case 401:
                    completion(.failure(NetworkError.unauthorized() as! E))
                    
                default:
                    completion(.failure(NetworkError.unknownError() as! E))
                }
            }
        }
        task.resume()
    }
    
    func get<T: Codable, E: NetworkErrorProtocol>(url: URL, headers: [String: String]? = nil, completion: @escaping (Result<T, E>) -> Void) {
        sendRequest(url: url, method: .get, headers: headers, completion: completion)
    }
    
    func post<T: Codable, E: NetworkErrorProtocol>(url: URL, headers: [String: String]? = nil, body: Data, completion: @escaping (Result<T, E>) -> Void) {
        sendRequest(url: url, method: .post, headers: headers, body: body, completion: completion)
    }
    
    func put<T: Codable, E: NetworkErrorProtocol>(url: URL, headers: [String: String]? = nil, body: Data, completion: @escaping (Result<T, E>) -> Void) {
        sendRequest(url: url, method: .put, headers: headers, body: body, completion: completion)
    }
    
    func delete<T: Codable, E: NetworkErrorProtocol>(url: URL, headers: [String: String]? = nil, completion: @escaping (Result<T, E>) -> Void) {
        sendRequest(url: url, method: .delete, headers: headers, completion: completion)
    }
}


