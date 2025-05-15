//
//  ZipHelper.swift
//  MiniappSDKDemoApplication
//
//  Created by Alexandr Sivash on 14.05.2025.
//

import Foundation

class ZipHelper {
    enum CreateZipError: Error {
        case urlNotADirectory(URL)
        case failedToCreateZIP(Swift.Error)
    }
    
    @discardableResult
    static func createZip(zipFinalURL: URL, fromDirectory directoryURL: URL) throws -> URL {
        guard directoryURL.isDirectory else {
            throw CreateZipError.urlNotADirectory(directoryURL)
        }
        
        var fileManagerError: Swift.Error?
        var coordinatorError: NSError?
        let coordinator = NSFileCoordinator()
        
        if FileManager.default.fileExists(atPath: zipFinalURL.path) {
            try? FileManager.default.removeItem(at: zipFinalURL)
        }
        
        coordinator.coordinate(
            readingItemAt: directoryURL,
            options: .forUploading,
            error: &coordinatorError
        ) { zipCreatedURL in
            do {
                try FileManager.default.moveItem(at: zipCreatedURL, to: zipFinalURL)
            } catch {
                fileManagerError = error
            }
        }
        if let error = coordinatorError ?? fileManagerError {
            throw CreateZipError.failedToCreateZIP(error)
        }
        return zipFinalURL
    }
}

extension URL {
    var isDirectory: Bool {
        return (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}
