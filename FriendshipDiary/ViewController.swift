//
//  ViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 04/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func action(_ sender: Any) {
        SVProgressHUD.show()
        NetworkManager.login(userName: "akowalski", password: "password", successBlock: { (dict) in
            SVProgressHUD.popActivity()
            let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
            if let token = try? JSONDecoder().decode(ApiItemToken.self, from: data!) {
                NetworkManager.sessionToken = token.token ?? ""
            }
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
    @IBAction func register(_ sender: Any) {
        SVProgressHUD.show()
        NetworkManager.register(userName: "akowalski", password: "password", firstName: "firsname", lastName: "lasname", successBlock: { (data) in
            SVProgressHUD.popActivity()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
    
    @IBAction func getMemories(_ sender: Any) {
        SVProgressHUD.show()
        NetworkManager.getMemories(successBlock: { (dict) in
            guard let dict = dict else { return }
            guard let items = dict["items"] as? [[String:Any]] else { return }
            let data = try? JSONSerialization.data(withJSONObject: items, options: [])
            if let memories = try? JSONDecoder().decode([ApiItemMemory].self, from: data!) {
                let imageString = memories[0].image 
                let image = UIImage(base64: imageString)
                self.imageView.image = image
                SVProgressHUD.popActivity()
                
            }
            SVProgressHUD.popActivity()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
    
}

