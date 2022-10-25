//
//  DemoApplicationServerEmulation.swift
//  CordovaDemoApp
//
//  Created by MIKHAIL CHEPELEV on 02.05.2022.
//

import Foundation

@objc public class DemoApplicationServerEmulation: NSObject {
    let client = DemoAPIClient()
    
    func authFrom(client: String, secret: String) -> String {
        let data = String(format: "%@:%@", client, secret).data(using: String.Encoding.utf8)!
        return data.base64EncodedString()
    }
    
    @objc public func sendCodeToServer(code: String, clientId: String, clientSecret: String, complition: ((String?)->Void)? = nil) {
        let url = "https://v1.doma.ai/oidc/token"
        client.performRequest(url: url, isPost: true, body: "grant_type=authorization_code&code=\(code)&redirect_uri=https%3A%2F%2Fmobile.doma.ai", authorization: authFrom(client: clientId, secret: clientSecret)) { data in
            complition?(data.body ?? data.url)
        } failed: { _ in complition?(nil) }
    }
}
