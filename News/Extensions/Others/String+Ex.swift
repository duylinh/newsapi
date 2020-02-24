//
//  String+Ex.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation

extension String {
    func appendingComponent(_ name: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(name)
    }
}
