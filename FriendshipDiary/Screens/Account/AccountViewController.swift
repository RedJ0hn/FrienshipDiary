//
//  AccountViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 11/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logout(_ sender: Any) {
        NetworkManager.sessionToken = ""
        tabBarController?.navigationController?.popViewController(animated: true)
    }
    
}
