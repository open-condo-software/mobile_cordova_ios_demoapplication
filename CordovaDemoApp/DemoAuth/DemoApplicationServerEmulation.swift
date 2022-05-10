//
//  DemoApplicationServerEmulation.swift
//  CordovaDemoApp
//
//  Created by MIKHAIL CHEPELEV on 02.05.2022.
//

import Foundation

// ВНИМАНИЕ!
//  У нас чуть не доделана поддержка методов авторизации и на текущий момент доступен только следующий вариант.
//  Этот класс предоставляет функционал, который реализуется вашим сервером для приложения
//  Среди его функционала должен быть метод авторизации по коду, полученному клиентом от основного приложения
//  Сервер подтверждает этот код у сервера Домов и меняет на авторизацию, которую использует для получения нужных данных, на основе которых создаёт
//  необходимые записи у себя и авторизует свой клиент

@objc public class DemoApplicationServerEmulation: NSObject {
    let redirectURI = "https://myServer.demo.com"
    let client = DemoAPIClient()
    
    // сервер должен получить клиент айди и секрет что бы ставить заголовок авторизации
    // Base64(clientId:clientSecret)
    let authoriztionHeader = "Basic bWluaWFwcC1tb2JpbGUtdGVzdC13ZWI6VjNLUUhTakNZUjZQOXpQUXhFWWM4S1d3Zmk5WE5WbW4="
    
    @objc public func sendCodeToServer(code: String, clientId: String, clientSecret: String, complition: ((String?)->Void)? = nil) {
        let url = "https://v1.doma.ai/oidc/token"
        // тут надо айди и секрет переделать в авторизацию, но пока возбмём предзаготовленную
        client.performRequest(url: url, isPost: true, body: "grant_type=authorization_code&code=\(code)&redirect_uri=https%3A%2F%2Fmobile.doma.ai", authorization: authoriztionHeader) { data in
            complition?(data)
        } failed: { _ in complition?(nil) }
    }
}
