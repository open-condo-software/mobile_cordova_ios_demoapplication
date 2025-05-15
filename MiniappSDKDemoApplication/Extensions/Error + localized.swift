//
//  Error + localized.swift
//  MiniappSDKDemoApplication
//
//  Created by Alexandr Sivash on 14.05.2025.
//

import Foundation

public extension NSError {
    convenience init(localizedDescription: String) {
        let userInfo: [String: Any] = [NSLocalizedDescriptionKey : localizedDescription]
        self.init(domain: "", code: 0, userInfo: userInfo)
    }
}
