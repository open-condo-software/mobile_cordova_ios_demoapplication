//
//  SceneDelegate.swift
//  MiniappSDKDemoApplication
//
//  Created by Alexandr Sivash on 13.05.2025.
//

import UIKit
import MiniappSDK_demo

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: RootViewController.shared)
        
        let screenSize = UIScreen.main.bounds.size
        windowScene.sizeRestrictions?.minimumSize = CGSize(width: min(screenSize.width, 100), height: min(screenSize.height - 40, 800))
        windowScene.sizeRestrictions?.maximumSize = CGSize(width: min(screenSize.width, 600), height: min(screenSize.height - 40, 1200))
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard
            let urlContext = URLContexts.first,
            urlContext.url.isFileURL,
            FileManager.default.fileExists(atPath: urlContext.url.path)
        else {
            return
        }
        
        guard let sdk = MiniappsSDK.shared else {
            return alert(title: "Installation error", subTitle: "SDK is uninitialized")
        }
        
        do {
            try sdk.installDebugMiniapp(filePath: urlContext.url.path)
        } catch {
            alert(title: "Installation error", subTitle: error.localizedDescription)
            return
        }
        
        guard let rootViewController = window?.rootViewController as? UINavigationController else {
            return alert(title: "Launching error", subTitle: "UI not ready")
        }
        
        sdk.launchMiniapp(
            appId: MiniappsSDK.debugMiniappID,
            addressID: MiniappsSDK.debugMiniappID,
            launchType: .present(over: rootViewController, animated: true)
        )
    }
    
    private func alert(title: String, subTitle: String) {
        let alert = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        window?.rootViewController?.present(alert, animated: true)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

