//
//  UIViewController + alert.swift
//  MiniappSDKDemoApplication
//
//  Created by Alexandr Sivash on 13.05.2025.
//

import UIKit

extension UIViewController {
    
    func showAlert(message: String, actionTitle: String? = nil, block: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        if actionTitle != nil || block != nil {
            alert.addAction(.init(title: actionTitle, style: .default, handler: { _ in
                block?()
            }))
            
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alert.dismiss(animated: true)
            }
        }
        
        present(alert, animated: true)
    }
}
