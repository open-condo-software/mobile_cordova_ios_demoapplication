//
//  DefaultClient.swift
//  ServerSide
//
//  Created by MIKHAIL CHEPELEV on 17.08.2021.
//

import Foundation

extension HTTPCookiePropertyKey {
    static let httpOnly = HTTPCookiePropertyKey("HttpOnly")
}

struct APIClientResponce {
    let url: String?
    let body: String?
    let status: Int
    let cookies: [HTTPCookie]
    var dictionaryRepresentation: [String: Any] {
        var result: [String: Any] = ["status": status,
                                    "cookies": cookies]
        if let url = url {
            result["url"] = url
        }
        if let body = body {
            result["body"] = body
        }
        return result
    }
}

class DemoAPIClient: NSObject, URLSessionTaskDelegate {
    
    var session: URLSession?
    
    func getOrCreateSession(cookie: HTTPCookie?) -> URLSession {
        if let session = session { return session }
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.urlCache = nil
        if let cookie = cookie {
            config.httpCookieStorage?.setCookie(cookie)
        }
        
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        self.session = session
        return session
    }
    
    var complition: ((APIClientResponce)->Void)?
    var result: String?
    var lastRequest: URLRequest?
    weak var currentRequest: URLSessionDataTask?
    
    func performRequest(url: String, isPost: Bool = false, body: String? = nil, cookie: HTTPCookie? = nil, authorization: String? = nil, success: @escaping (APIClientResponce)->Void, failed: @escaping ([Error])->Void) {
        guard let url = URL(string: url) else {
            failed([])
            return
        }
        self.complition = success
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        if let authorization = authorization {
            request.addValue(authorization, forHTTPHeaderField: "Authorization")
        }
        if isPost {
            request.httpMethod = "POST"
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Responce-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = body?.data(using: .utf8)
        }
        self.result = nil
        lastRequest = request
        currentRequest?.cancel()
        currentRequest = nil
        currentRequest = getOrCreateSession(cookie: cookie).dataTask(with: request) { [weak self] result, responce, error in
            var cookies = [HTTPCookie]()
            HTTPCookieStorage.shared.cookies?.forEach({ cookie in
                if !cookie.domain.contains("doma.ai") {
                    cookies.append(cookie)
                } else if cookie.domain.contains("miniapp") {
                    cookies.append(cookie)
                }
                HTTPCookieStorage.shared.deleteCookie(cookie)
            })
            success(APIClientResponce(url: self?.lastRequest?.url?.absoluteString,
                                      body: String(data: self?.lastRequest?.httpBody ?? Data(), encoding: .utf8),
                                      status: (responce as? HTTPURLResponse)?.statusCode ?? 200,
                                      cookies: cookies))
        }
        currentRequest?.resume()
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        lastRequest = request
        completionHandler(request)
    }
}
