//
//  FriendsViewPresenter.swift
//  FriendshipDiary
//
//  Created by Mateusz on 13/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

class FriendViewPresenter {
    
    var friends: [ApiItemUser] = []
    
    func loadFriends(successBlock: @escaping ()->(), failtureBlock: @escaping (ApiItemError?)->()) {
        NetworkManager.getFriends(successBlock: { (dict) in
            guard let dict = dict else { return }
            guard let items = dict["items"] as? [[String:Any]] else { return }
            guard let data = try? JSONSerialization.data(withJSONObject: items, options: []) else { return }
            self.friends = (try? JSONDecoder().decode([ApiItemUser].self, from: data)) ?? []
            successBlock()
        }, failtureBlock: failtureBlock)
    }
    
    func deleteFriend(username: String, successBlock: @escaping ()->(), failtureBlock: @escaping (ApiItemError?)->()) {
        NetworkManager.deleteFriend(username: username, successBlock: { (_) in
            successBlock()
        }, failtureBlock: failtureBlock)
    }
    
}
