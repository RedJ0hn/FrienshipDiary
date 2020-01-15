//
//  FriendsViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 13/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit
import SVProgressHUD

class FriendsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var presenter = FriendViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData() {
        SVProgressHUD.show()
        presenter.loadFriends(successBlock: {
            self.tableView.reloadData()
            SVProgressHUD.popActivity()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddFriendsViewController {
            destination.delegate = self
        }
    }

}

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendsTableViewCell {
            let currentFriend = presenter.friends[indexPath.row]
            cell.configure(with: currentFriend)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension FriendsViewController: FriendTableViewCellDelegate {
    func deleteFriend(username: String?) {
        SVProgressHUD.show()
        guard let username = username else { return }
        presenter.deleteFriend(username: username, successBlock: {
            self.loadData()
            SVProgressHUD.popActivity()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
}

extension FriendsViewController: AddFirendViewControllerDelegate {
    func wasDissmissed() {
        loadData()
    }
}
