//
//  ErrorViewModel.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation

struct ErrorViewModel {
    
    // MARK: Properties
    
    let title: String
    let message: String
    
    // MARK: Initialization
    
    init(title: String, message: String) {
        self.title = title
        self.message = message
    }
    
    init(error: Error) {
        self.title = NSLocalizedString("Error", comment: "")
        self.message = error.localizedDescription
    }
}
