//
//  AppViewController.swift
//  MiniappSDKDemoApplication
//
//  Created by Alexandr Sivash on 13.05.2025.
//

import UIKit
import MiniappSDK_demo

class RootViewController: UIViewController {
    static let shared = RootViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let splashViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "LaunchScreen")
        setContentController(viewController: splashViewController, animated: false)
        
        start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        didAppear = true
        proceedIfReady(addressID: nil)
    }
    
    var isStarting: Bool = false
    func start() {
        guard !isStarting else { return }
        isStarting = true
        
        MiniappsSDK.login(clientIdSecret: "demo", environment: .devevelopment) { [weak self] result in
            guard let self else { return }
            self.isStarting = false
            
            switch result {
            case .success(let sdk):
                
                //Demo version is restricted to 1 hardcoded address. Argument is ignored.
                let addressDecriptor = MiniappsSDK.PartnerClientAddress(address: "Ростовская обл, г Ростов-на-Дону, ул Кудрявая, д 6", unitName: "88", unitType: .flat)
                sdk.setAddress(addressList: [addressDecriptor]) { [weak self] addressResults in
                    guard let self else { return }
                    guard let firstAddressResult = addressResults.first?.value else {
                        return
                    }
                    
                    switch firstAddressResult {
                    case .success(let addressID):
                        proceedIfReady(addressID: addressID)
                        
                    case .failure(let error):
                        showAlert(message: "SDK failed to set address: \(error.localizedDescription)")
                    }
                }
                
                print("MiniappSDK successfully initialized")
                didStart = true
                
            case .failure(let error):
                showAlert(message: "SDK failed to start: \(error.localizedDescription)")
            }
        }
    }
    
    var didStart: Bool = false
    var didAppear: Bool = false
    var didProceed: Bool = false
    
    func installBundledMiniapp() throws -> URL {
        let baseBundleURl = Bundle(for: Self.self).bundleURL
        guard let miniappBundle = Bundle(url: baseBundleURl.appendingPathComponent("BundledMiniapp.bundle").appendingPathComponent("www")) else {
            throw NSError.init(localizedDescription: "Failed to find base bundle")
        }
        
        let destinationURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("bundledMiniapp.zip")
        return try ZipHelper.createZip(zipFinalURL: destinationURL, fromDirectory: miniappBundle.bundleURL)
    }
    
    var stashedAddressID: String?
    func proceedIfReady(addressID: String?) {
        guard !didProceed else { return }
        stashedAddressID = addressID
        
        guard didStart && didAppear else { return }
        guard let addressID = addressID ?? stashedAddressID else { return }
        
        didProceed = true
        
        do {
            let archivedMiniapp = try installBundledMiniapp()
            try MiniappsSDK.shared?.installDebugMiniapp(filePath: archivedMiniapp.path)
            
        } catch {
            showAlert(message: error.localizedDescription, actionTitle: "Ok")
            return
        }
        
        setContentController(viewController: UINavigationController(rootViewController: AppViewController(addressID: addressID)))
    }
    
    weak var lastKnownContentController: UIViewController?
    func setContentController(viewController: UIViewController, animated: Bool = true) {
        func commit() {
            lastKnownContentController?.dismiss(animated: false)
            lastKnownContentController?.view.removeFromSuperview()
            lastKnownContentController?.willMove(toParent: nil)
            lastKnownContentController?.removeFromParent()
            
            lastKnownContentController = viewController
            let splashView = viewController.view!
            splashView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(splashView)
            NSLayoutConstraint.activate([
                splashView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                splashView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                splashView.topAnchor.constraint(equalTo: view.topAnchor),
                splashView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
            
            view.addSubview(viewController.view)
            addChild(viewController)
            viewController.didMove(toParent: self)
        }
        
        if animated {
            view.fadeTransitionAnimation(duration: 0.1, block: commit)

        } else {
            commit()
        }
    }
}
