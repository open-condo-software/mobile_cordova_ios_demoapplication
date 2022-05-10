//
//  ViewController.swift
//  CordovaDemoApp
//
//  Created by MIKHAIL CHEPELEV on 26.04.2022.
//

import UIKit
import Cordova

enum MiniappPresentationStyle: String {
    case push
    case push_with_navigation
    case present
    case pesent_fullscreen
    case pesent_fullscreen_with_navigation
}

class ViewController: UIViewController {

    let clientAuth = DemoApplicationMainAppAPI()
    let serverMoc = DemoApplicationServerEmulation()
    weak static var currentInstance: ViewController?
    
    var currentMiniapp: UIViewController?
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func launchCordovaApp(button: UIButton) {
        //  в реальном приложении перед этим будет скачивание миниапп с сервера и распаковка в локальную директорию
        //  тут мы просто сделаем линк в проект
        let ctr = CDVViewController()
        currentMiniapp = ctr
        ctr.view.backgroundColor = .white
        ctr.wwwFolderName = "www"
        
        var presentationStyle = MiniappPresentationStyle.pesent_fullscreen
        if let configPath = Bundle.main.path(forResource: "native_config", ofType: "json", inDirectory: "www") {
            let configUrl = URL(fileURLWithPath: configPath)
            if let data = try? Data(contentsOf: configUrl) {
                if let config = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let style = config["presentation-style"] as? String {
                        if let styleOption = MiniappPresentationStyle(rawValue: style) {
                            presentationStyle = styleOption
                        }
                    }
                }
            }
        }
        
        switch presentationStyle {
        case .push:
            currentMiniappPresented = false
            navigationController?.pushViewController(ctr, animated: true)
        case .push_with_navigation:
            currentMiniappPresented = false
            navigationController?.pushViewController(ctr, animated: true)
            navigationController?.setNavigationBarHidden(false, animated: true)
        case .present:
            currentMiniappPresented = true
            self.present(ctr, animated: true)
        case .pesent_fullscreen:
            currentMiniappPresented = true
            ctr.modalPresentationStyle = .fullScreen
            self.present(ctr, animated: true)
        case .pesent_fullscreen_with_navigation:
            currentMiniappPresented = true
            ctr.modalPresentationStyle = .fullScreen
            self.present(ctr, animated: true)
        }
    }
}
