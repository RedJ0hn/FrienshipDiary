//
//  AddFriendsTableViewCell.swift
//  FriendshipDiary
//
//  Created by Mateusz on 13/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit

protocol AddFriendTableViewCellDelegate: class {
    func addFriend(username: String?)
}

class AddFriendsTableViewCell: UITableViewCell {

    weak var delegate: AddFriendTableViewCellDelegate?
    var username: String?
    
    @IBOutlet weak var userNameLabel: UILabel!

    func configure(with user: ApiItemUser?) {
        userNameLabel.text = (user?.firstname ?? "") + " " + (user?.lastname ?? "")
        username = user?.username
        
    }
    @IBAction func addFriendTapped(_ sender: Any) {
        delegate?.addFriend(username: username)
    }
    
}
