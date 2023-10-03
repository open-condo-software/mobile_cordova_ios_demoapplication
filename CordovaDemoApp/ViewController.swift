//
//  ViewController.swift
//  CordovaDemoApp
//
//  Created by MIKHAIL CHEPELEV on 26.04.2022.
//

import UIKit
import Cordova

enum MiniappPresentationStyle: String {
    case native
}

class MiniappCordovaViewController: CDVViewController, UINavigationBarDelegate {
    
    let mNavigationBar = UINavigationBar()
    var navigationCache = [UINavigationItem: [String: Any]]()
    
    deinit {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: records, completionHandler: {})
        }
    }

    
    func createBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .close, primaryAction: UIAction(handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))
    }

    
    func setupNavigationBar() {
        mNavigationBar.delegate = self
        view.addSubview(mNavigationBar)
        mNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        let statusHeight = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.windowScene?.statusBarManager?.statusBarFrame.height ?? 20
        mNavigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: statusHeight - 1/UIScreen.main.scale).isActive = true
        mNavigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mNavigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mNavigationBar.pushItem(self.navigationItem, animated: false)
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBackButton()
        setupNavigationBar()
        
        if #available(iOS 16.4, *) {
            (self.webView as? WKWebView)?.isInspectable = true
        }
    }
    
    /////////////////////HISTORY////////////////////
    
    @objc func pushState(state: Any, title: String) -> String? {
        let item = UINavigationItem(title: title)
        let localState = ["title": title, "state": state] as [String : Any]
        navigationCache[item] = localState
        mNavigationBar.pushItem(item, animated: true)
        notifyPopState(info: localState)
        return nil
    }
    
    @objc func replaceState(state: Any, title: String) -> String? {
        let localState = ["title": title, "state": state] as [String : Any]
        if mNavigationBar.items?.count ?? 0 == 1, let item = mNavigationBar.items?.first {
            navigationCache[item] = localState
            self.title = title
        } else {
            let item = UINavigationItem(title: title)
            navigationCache[item] = localState
            popItem(animated: false)
            mNavigationBar.pushItem(item, animated: false)
        }
        notifyPopState(info: localState)
        return nil
    }
    
    @discardableResult func popItem(animated: Bool) -> [String: Any]? {
        if let item = mNavigationBar.popItem(animated: animated) {
            return navigationCache.removeValue(forKey: item)
        }
        return nil
    }
    
    func notifyPopState(info: [String: Any]?) {
        guard condoPopeventNotificationEnabled == true else { return }
        var info = info
        if info == nil, let item = mNavigationBar.items?.last {
            info = navigationCache[item]
        }
        if let state = info?["state"] {
            var stateString = "{}"
            if JSONSerialization.isValidJSONObject(state), let data = try? JSONSerialization.data(withJSONObject: state) {
                stateString = String(data: data, encoding: .utf8) ?? stateString
            } else if let string = state as? String {
                stateString = "'\(string)'"
            } else if let number = state as? NSNumber {
                stateString = number.stringValue
            }
            self.commandDelegate.evalJs("window.dispatchEvent(new PopStateEvent('condoPopstate', { 'state': \(stateString)}));")
        } else {
            self.commandDelegate.evalJs("window.dispatchEvent(new PopStateEvent('condoPopstate', { 'state': null }));")
        }
    }
    
    @objc func go(to delta: Int = 1) -> String? {
        guard let items = mNavigationBar.items, items.count > 1 else {
            return "Nothing to pop"
        }
        let absDelta = abs(delta)
        guard absDelta < items.count else {
            return "Incorrect delta"
        }
        preformWithoutCondoPopeventNotification {
            for _ in 0 ..< (absDelta-1) {
                popItem(animated: false)
            }
            popItem(animated: true)
        }
        notifyPopState(info: nil)
        return nil
    }
    
    @objc func back() -> String? {
        return go()
    }
    
    var condoPopeventNotificationEnabled = true
    
    func preformWithoutCondoPopeventNotification(_ block:()->Void) {
        condoPopeventNotificationEnabled = false
        block()
        condoPopeventNotificationEnabled = true
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        self.commandDelegate.evalJs("cordova.fireDocumentEvent('backbutton');")
        navigationCache.removeValue(forKey: item)
        if let count = mNavigationBar.items?.count, count > 1, let prevItem = mNavigationBar.items?[count - 2] {
            notifyPopState(info: navigationCache[prevItem])
        } else {
            notifyPopState(info: nil)
        }
        return true
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
        if navigationCache[item] != nil {
            self.commandDelegate.evalJs("cordova.fireDocumentEvent('backbutton');")
            navigationCache.removeValue(forKey: item)
            notifyPopState(info: nil)
        }
    }
}

class ViewController: UIViewController {

    let clientAuth = DemoApplicationMainAppAPI()
    weak static var currentInstance: ViewController?
    
    weak var currentMiniapp: UIViewController?
    var currentMiniappPresented = false

    
    func closeMiniapp() {
        guard currentMiniapp != nil else { return }
        if currentMiniappPresented && (presentedViewController != nil) {
            dismiss(animated: true)
        } else if !currentMiniappPresented && (navigationController?.viewControllers.count ?? 0) > 1 {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewController.currentInstance = self
        
        let scroll = UIScrollView()
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scroll.topAnchor.constraint(equalTo: view.topAnchor, constant: 86).isActive = true
        scroll.heightAnchor.constraint(equalToConstant: 118).isActive = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.canCancelContentTouches = true
        
        var prevView: UIView? = nil
        for index in 0..<10 {
            let miniappButton = MiniappView()
            miniappButton.translatesAutoresizingMaskIntoConstraints = false
            scroll.addSubview(miniappButton)
            miniappButton.leadingAnchor.constraint(equalTo: prevView?.trailingAnchor ?? scroll.leadingAnchor, constant: (prevView != nil) ? 8 : 20).isActive = true
            miniappButton.topAnchor.constraint(equalTo: scroll.topAnchor).isActive = true
            miniappButton.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true
            miniappButton.tag = index
            miniappButton.addTarget(self, action: #selector(ViewController.launchCordovaApp(button:)), for: .touchUpInside)
            prevView = miniappButton
        }
        prevView?.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -20).isActive = true
    }
    
    func setCookies(cookies: [HTTPCookie]?) {
        if let cordova = currentMiniapp as? CDVViewController {
            if let webView = cordova.webViewEngine.engineWebView as? WKWebView {
                cookies?.forEach({ cookie in
                    webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
                })
                cookiesDidChange(in: webView.configuration.websiteDataStore.httpCookieStore)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func launchCordovaApp(button: UIButton) {
        //  в реальном приложении перед этим будет скачивание миниапп с сервера и распаковка в локальную директорию
        //  тут мы просто сделаем линк в проект
        let ctr = MiniappCordovaViewController()
        currentMiniapp = ctr
        ctr.view.backgroundColor = .white
        ctr.wwwFolderName = "www"
        var cookies = [HTTPCookie]()
        
        UserDefaults.standard.array(forKey: "miniapp_cookies")?.forEach({ element in
            if let element = element as?  [HTTPCookiePropertyKey : Any], let cookie = HTTPCookie(properties: element) {
                cookies.append(cookie)
            }
        })
        
        setCookies(cookies: cookies)

        currentMiniappPresented = true
        ctr.modalPresentationStyle = .fullScreen
        self.present(ctr, animated: true)
        
        if let cordova = currentMiniapp as? CDVViewController {
            if let webView = cordova.webViewEngine as? WKWebView {
                webView.configuration.websiteDataStore.httpCookieStore.add(self)
            }
        }
    }
}

extension ViewController: WKHTTPCookieStoreObserver {
    func cookiesDidChange(in cookieStore: WKHTTPCookieStore) {
        cookieStore.getAllCookies { cookies in
            print("save cookies \(cookies)")
            UserDefaults.standard.set(cookies.compactMap({ cookie in
                return cookie.properties
            }), forKey: "miniapp_cookies")
        }
    }
}
