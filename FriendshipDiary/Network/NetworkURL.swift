//
//  ViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 04/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

struct Link {
    
    let endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    init(endpoint: String, param: String) {
        self.endpoint = endpoint + "/" + param
    }
    
    var full: String { return NetworkURL.baseAddress + endpoint }
}

class NetworkURL {
    
    static let baseAddress: String = "http://friendshipdiarynossl.westeurope.azurecontainer.io:5000/api/"

    let postLogin = Link(endpoint: "login")
    let postRegister = Link(endpoint: "register")
    
    // Memories
    let getMemories = Link(endpoint: "memories")
    let postMemory = Link(endpoint: "memory")
    let getMemoriesDraft = Link(endpoint: "memories/drafts")
    let postMemoriesDraft = Link(endpoint: "memories/draft")
    
    
    //Friends
    let getFriends = Link(endpoint: "friends")
    func postFriend(username: String) -> Link {
        return Link(endpoint: "friend", param: username)
    }
    func deleteFriend(username: String) -> Link {
        return Link(endpoint: "friend", param: username)
    }
    let getUsers = Link(endpoint: "users")
}
