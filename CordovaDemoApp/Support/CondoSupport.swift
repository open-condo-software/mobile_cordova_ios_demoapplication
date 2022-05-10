//
//  CondoSupport.swift
//  CordovaDemoApp
//
//  Created by MIKHAIL CHEPELEV on 09.05.2022.
//

import Foundation

@objc class CondoSupport: NSObject {
    static let instance = CondoSupport()
    
    @objc public static func getInstance() -> CondoSupport {
        return instance
    }
    
    @objc public func closeApp() {
        ViewController.currentInstance?.closeMiniapp()
    }
}
