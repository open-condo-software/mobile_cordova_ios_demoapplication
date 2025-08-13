//
//  AppViewController.swift
//  MiniappSDKDemoApplication
//
//  Created by Alexandr Sivash on 13.05.2025.
//

import UIKit
import MiniappSDK_demo

class AppViewController: UIViewController {
    
    let addressID: String
    init(addressID: String) {
        self.addressID = addressID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var mButtonStart: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addInteraction(UIDropInteraction(delegate: self))
        
        let startButton = UIButton()
        mButtonStart = startButton
        startButton.backgroundColor = .systemGreen
        startButton.layer.cornerRadius = 8
        
        startButton.setTitle("Запустить миниапп", for: .normal)
        startButton.setTitleColor(UIColor.systemBlue, for: .normal)
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    var isStarting: Bool = false
    @objc func start() {
        guard let miniappSDK = MiniappsSDK.shared else { return }
        
        guard !isStarting else { return }
        isStarting = true
        
        miniappSDK.launchMiniapp(
            appId: MiniappsSDK.debugMiniappID,
            addressID: addressID,
            launchType: .present(over: self, animated: true)
        ) { [weak self] error in
            self?.isStarting = false
            
            if let error {
                self?.showAlert(message: "Error: \(error.localizedDescription)")
            }
        }
    }
}

import Foundation
import UniformTypeIdentifiers
import CoreServices

extension AppViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: ["public.file-url", "public.data"])
    }
    
    // Define drop behavior (e.g., copy files)
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    // Handle the dropped files
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for item in session.items {
            item.itemProvider.loadItem(forTypeIdentifier: "public.data") { some, error in
                guard let fileURL = some as? URL else { return }
                // Process the file (e.g., copy to app’s directory)
                self.handleDroppedFile(fileURL)
            }
        }
    }
    
    func handleDroppedFile(_ fileURL: URL) {
        guard fileURL.startAccessingSecurityScopedResource() else { return }
        defer { fileURL.stopAccessingSecurityScopedResource() }
        
        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
            
            try? FileManager.default.removeItem(at: destinationURL)
            try FileManager.default.copyItem(at: fileURL, to: destinationURL)
            print("File saved to: \(destinationURL)")
            
            guard let sdk = MiniappsSDK.shared else {
                return alert(title: "Installation error", subTitle: "SDK is uninitialized")
            }
            
            do {
                try sdk.installDebugMiniapp(filePath: destinationURL.path)
            } catch {
                alert(title: "Installation error", subTitle: error.localizedDescription)
                return
            }
            
            sdk.launchMiniapp(
                appId: MiniappsSDK.debugMiniappID,
                addressID: MiniappsSDK.debugMiniappID,
                launchType: .present(over: self, animated: true)
            )
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func alert(title: String, subTitle: String) {
        let alert = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
