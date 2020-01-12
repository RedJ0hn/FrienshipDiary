//
//  LoginViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 11/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: BaseViewController {

    lazy var presenter = LoginViewPresenter()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        usernameTextField.text = "akowalski"
        passwordTextField.text = "password"
        #endif
        // Do any additional setup after loading the view.
    }
    @IBAction func loginTapped(_ sender: Any) {
        presenter.username = usernameTextField.text
        presenter.password = passwordTextField.text
        SVProgressHUD.show()
        presenter.loginAction(successBlock: {
            SVProgressHUD.popActivity()
            self.performSegue(withIdentifier: "loginSuccess", sender: nil)
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
    
}
