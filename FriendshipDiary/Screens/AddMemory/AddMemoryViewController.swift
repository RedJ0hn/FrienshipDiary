//
//  AddMemoryViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 14/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

class AddMemoryViewController: BaseViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var choosedPhotoImageView: UIImageView!
    
    lazy var presenter = AddMemoryViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.layer.borderColor = UIColor.systemGray3.cgColor
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 5
        friendsTableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        SVProgressHUD.show()
        presenter.getFriends(successBlock: {
            self.friendsTableView.reloadData()
            SVProgressHUD.popActivity()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }

    @IBAction func choosePhoto(_ sender: Any) {
    }
    @IBAction func publish(_ sender: Any) {
    }
    @IBAction func saveToDrafts(_ sender: Any) {
    }
    
}

extension AddMemoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = friendsTableView.dequeueReusableCell(withIdentifier: "FriendCell") {
            let currentFriend = presenter.friends[indexPath.row]
            cell.textLabel?.text = (currentFriend.firstname ?? "") + " " + (currentFriend.lastname ?? "")
            return cell
        }
        return UITableViewCell()
    }
    
    
}
