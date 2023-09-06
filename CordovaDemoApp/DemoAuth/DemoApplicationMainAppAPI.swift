//
//  DemoApplicationMainAppAPI.swift
//  CordovaDemoApp
//
//  Created by MIKHAIL CHEPELEV on 02.05.2022.
//

import Foundation


//  Важно
//  Это то что будет делать основное приложение домов, миниапам не нужно об этом думать
//  миниап только получает результат авторизации

@objc public class DemoApplicationMainAppAPI: NSObject {
    let redirectURI = "https://mobile.doma.ai"
    let client = DemoAPIClient()
    let state = UUID().uuidString
    
    // этот токен под которым авторизован реальный пользователь в приложении домов
    let demotoken = "qPH3g4rOiFIgwlO5dUQLTPkgtSWmDrlG./ZBsbpIFHK4n8y0KI1YH1r93E0msi5p5h2s+H6IqwGg"
    public func authorizationCookie(for domain: String = "condo.d.doma.ai") -> HTTPCookie? {
        return HTTPCookie.init(properties: [.domain: domain,
                                            .path: "/",
                                            .name: "keystone.sid",
                                            .value: "s:\(demotoken)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "",
                                            .secure: true,
                                            .expires: NSDate(timeIntervalSinceNow: 31656926),
                                            .httpOnly: true])
    }
    
    @objc public func getFullAuthByUrl(url: String, complition: @escaping ([String: Any]?) -> Void) {
        client.performRequest(url: url, cookie: authorizationCookie()) { data in
            var dictionary = data.dictionaryRepresentation
            let cookies = data.cookies
            dictionary.removeValue(forKey: "cookies")
            ViewController.currentInstance?.setCookies(cookies: cookies)
            complition(dictionary)
        } failed: { errors in
            complition(nil)
        }
    }
    
    @objc public func getCode(clientID: String, complition: @escaping (String?) -> Void) {
        let url = "https://condo.d.doma.ai/oidc/auth?response_type=code&client_id=\(clientID)&redirect_uri=\(self.redirectURI)&scope=openid&state=\(state)"
        client.performRequest(url: url, cookie: authorizationCookie()) { data in
            if let responceURL = data.url, responceURL.starts(with: self.redirectURI) {
                if let comps = URLComponents(string: responceURL) {
                    complition(comps.queryItems?.first(where: { $0.name == "code"})?.value)
                    return
                }
            }
            complition(nil)
        } failed: { errors in
            complition(nil)
        }
    }
    
    func authValueFrom(client: String, secret: String) -> String {
        let data = String(format: "%@:%@", client, secret).data(using: String.Encoding.utf8)!
        return data.base64EncodedString()
    }
    
    @objc public func sendCodeToServer(code: String, clientId: String, clientSecret: String, complition: ((String?)->Void)? = nil) {
        let url = "https://condo.d.doma.ai/oidc/token"
        client.performRequest(url: url, isPost: true, body: "grant_type=authorization_code&code=\(code)&redirect_uri=https%3A%2F%2Fmobile.doma.ai", authorization: authValueFrom(client: clientId, secret: clientSecret)) { data in
            complition?(data.body ?? data.url)
        } failed: { _ in complition?(nil) }
    }
}
