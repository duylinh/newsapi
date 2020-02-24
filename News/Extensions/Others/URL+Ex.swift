//
//  URL+Ex.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation
// swiftlint:disable all

extension URL {
    static func sqliteStoreDirectory() -> URL {
        guard let path = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last?.absoluteString.replacingOccurrences(of: "file://", with: "").removingPercentEncoding else {
            let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
            return urls[urls.count-1]
        }
        let applicationName: String = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let pathSource = path.appendingComponent("\(applicationName)")
        return URL(fileURLWithPath: pathSource)
    }
    
    static func applicationDocumentsDirectory() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }

}
