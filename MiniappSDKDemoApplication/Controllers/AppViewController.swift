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

/*
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
            try FileManager.default.copyItem(at: fileURL, to: destinationURL)
            print("File saved to: \(destinationURL)")
        } catch {
            print("Error: \(error)")
        }
    }
}
*/
