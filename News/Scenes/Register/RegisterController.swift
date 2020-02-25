//
//  RegisterController.swift
//  News
//
//  Created by Duy Linh Tran on 2/25/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

class RegisterController: BaseController {

    internal static func instantiate() -> RegisterController {
        return Storyboard.Profile.instantiate(type: RegisterController.self)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action
    @IBAction func registerButtonTapped(_ sender: Any?) {
        self.dismiss(animated: false) {
            
        }
    }
}
