//
//  RegisterViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 11/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterViewController: BaseViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    lazy var presenter = RegisterViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        presenter.username = usernameTextField.text
        presenter.firstName = firstNameTextField.text
        presenter.lastName = lastNameTextField.text
        presenter.password = passwordTextField.text
        SVProgressHUD.show()
        presenter.registerAction(successBlock: {
            SVProgressHUD.popActivity()
            self.dismiss(animated: true, completion: nil)
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
    
}
