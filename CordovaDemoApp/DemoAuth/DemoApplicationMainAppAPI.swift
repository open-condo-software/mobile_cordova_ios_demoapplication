//
//  DemoApplicationMainAppAPI.swift
//  CordovaDemoApp
//
//  Created by MIKHAIL CHEPELEV on 02.05.2022.
//

import Foundation


//  Важно
//  Это то что будет делать основное приложение домов, миниапам не нужно об этом думать
//  миниап только получает кодик на выходе, который отдаёт своему серверу в обмен на авторизацию

@objc public class DemoApplicationMainAppAPI: NSObject {
    let clientID = "miniapp-mobile-test-web"
    let redirectURI = "https://mobile.doma.ai"
    let client = DemoAPIClient()
    let state = UUID().uuidString
    
    // этот токен под которым авторизован реальный пользователь в приложении домов
    let demotoken = "KlYvcTXy2q-l9BFp6zAW9rTP5zkEAT8G.6MUsnOI9KbOQTZMKkMiRw/r/Q8ixE2XWRWZ5J3WCFnI"
    public func authorizationCookie(for domain: String = "v1.doma.ai") -> HTTPCookie? {
        return HTTPCookie.init(properties: [.domain: domain,
                                            .path: "/",
                                            .name: "keystone.sid",
                                            .value: "s:\(demotoken)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "",
                                            .secure: true,
                                            .expires: NSDate(timeIntervalSinceNow: 31656926),
                                            .httpOnly: true])
    }
    
    @objc public func getCode(complition: @escaping (String?) -> Void) {
        let url = "https://v1.doma.ai/oidc/auth?response_type=code&client_id=\(self.clientID)&redirect_uri=\(self.redirectURI)&scope=openid&state=\(state)"
        client.performRequest(url: url, cookie: authorizationCookie()) { data in
            if let data = data, data.starts(with: self.redirectURI) {
                if let comps = URLComponents(string: data) {
                    complition(comps.queryItems?.first(where: { $0.name == "code"})?.value)
                    return
                }
            }
            complition(nil)
        } failed: { errors in
            complition(nil)
        }
    }
}
