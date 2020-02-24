//
//  FileManager+Ex.swift
//  News
//
//  Created by Duy Linh Tran on 2/25/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation

extension FileManager {
    
    // MARK: - ApplicationSupport
    
    static func clearApplicationSupportDirectoryContents() {
        guard let applicationSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first, let applicationSupportDirectoryContents = try? FileManager.default.contentsOfDirectory(atPath: applicationSupportURL.path) else {
            return
        }
        applicationSupportDirectoryContents.forEach {
            let fileURL = URL(fileURLWithPath: applicationSupportURL.path, isDirectory: true).appendingPathComponent($0)
            try? FileManager.default.removeItem(atPath: fileURL.path)
        }
    }
}
