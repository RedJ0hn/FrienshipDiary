//
//  AddFriendsViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 13/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AddFirendViewControllerDelegate: class {
    func wasDissmissed()
}

class AddFriendsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var presenter = AddFriendViewPresenter()
    
    weak var delegate: AddFirendViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SVProgressHUD.show()
        presenter.loadUsers(successBlock: {
            self.tableView.reloadData()
            SVProgressHUD.popActivity()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.wasDissmissed()
    }
    
}

extension AddFriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? AddFriendsTableViewCell {
            let currentFriend = presenter.friends[indexPath.row]
            cell.configure(with: currentFriend)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension AddFriendsViewController: AddFriendTableViewCellDelegate {
    func addFriend(username: String?) {
        guard let username = username else { return }
        SVProgressHUD.show()
        presenter.addFriend(username: username, successBlock: {
            SVProgressHUD.popActivity()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
}
