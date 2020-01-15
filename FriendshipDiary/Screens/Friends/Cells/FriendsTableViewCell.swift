//
//  FriendsTableViewCell.swift
//  FriendshipDiary
//
//  Created by Mateusz on 13/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit

protocol FriendTableViewCellDelegate: class {
    func deleteFriend(username: String?)
}

class FriendsTableViewCell: UITableViewCell {

    weak var delegate: FriendTableViewCellDelegate?
    var username: String?
    
    @IBOutlet weak var userNameLabel: UILabel!

    func configure(with user: ApiItemUser?) {
        userNameLabel.text = (user?.firstname ?? "") + " " + (user?.lastname ?? "")
        username = user?.username
        
    }
    @IBAction func deleteFriendTapped(_ sender: Any) {
        delegate?.deleteFriend(username: username)
    }
    
}
