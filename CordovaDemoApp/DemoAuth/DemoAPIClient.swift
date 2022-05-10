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

public class DemoAPIClient: NSObject, URLSessionTaskDelegate {
    
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
    
    var complition: ((String?)->Void)?
    var result: String?
    
    public func performRequest(url: String, isPost: Bool = false, body: String? = nil, cookie: HTTPCookie? = nil, authorization: String? = nil, success: @escaping (String?)->Void, failed: @escaping ([Error])->Void) {
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
        getOrCreateSession(cookie: cookie).dataTask(with: request) { result, responce, error in
            if (error as? NSError)?.code ?? 0 == -999 {
                return
            }
            if let result = self.result ?? String(data: result ?? Data(), encoding: .utf8) {
                DispatchQueue.main.async {
                    self.complition?(result)
                }
            } else {
                failed([error ?? NSError(domain: "com.doma.domain", code: -1, userInfo: nil)])
            }
        }.resume()
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        if ((request.url?.absoluteString.hasPrefix("https://v1.doma.ai/oidc") ?? false) && (task.originalRequest?.url?.absoluteString.hasPrefix("https://v1.doma.ai/oidc") ?? false)) ||
            ((request.url?.absoluteString.hasPrefix("https://v1.doma.ai/auth") ?? false) && (task.originalRequest?.url?.absoluteString.hasPrefix("https://v1.doma.ai/auth") ?? false)){
            completionHandler(request)
            return
        }
        self.complition?(request.url?.absoluteString)
        task.cancel()
//        это ошибка... специально сделанная)
//        completionHandler(nil)
    }
}
