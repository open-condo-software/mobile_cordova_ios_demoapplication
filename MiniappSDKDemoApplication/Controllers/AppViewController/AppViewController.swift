//
//  AppViewController.swift
//  MiniappSDKDemoApplication
//
//  Created by Alexandr Sivash on 13.05.2025.
//

import UIKit
import MiniappSDK_demo
import UniformTypeIdentifiers

class AppViewController: UIViewController {
    
    let addressID: String
    init(addressID: String) {
        self.addressID = addressID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mViewContent = View()
    override func loadView() {
        self.view = mViewContent
    }
    
    var mButtonStart: UIButton? { mViewContent.startButton }
    var mButtonPick: UIButton? { mViewContent.pickButton }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mViewContent.startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        mViewContent.pickButton.addTarget(self, action: #selector(pickZipFile), for: .touchUpInside)
        mViewContent.dropContainer.addInteraction(UIDropInteraction(delegate: self))
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
    
    @objc func pickZipFile() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.file-url", "public.data"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
}

extension AppViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let fileURL = urls.first else { return }
        handleDroppedFile(fileURL)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // Handle cancellation if needed
    }
}

extension AppViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: ["public.file-url", "public.data"])
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: any UIDropSession) {
        mViewContent.dropContainer.backgroundColor = UIColor.green.withAlphaComponent(0.1)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidExit session: any UIDropSession) {
        mViewContent.dropContainer.backgroundColor = AppViewController.View.Constants.dropContainerDefaultColor
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, concludeDrop session: any UIDropSession) {
        mViewContent.dropContainer.backgroundColor = AppViewController.View.Constants.dropContainerDefaultColor
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for item in session.items {
            item.itemProvider.loadItem(forTypeIdentifier: "public.data") { some, error in
                guard let fileURL = some as? URL else { return }
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
