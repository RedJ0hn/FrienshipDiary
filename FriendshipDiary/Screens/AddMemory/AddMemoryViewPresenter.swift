//
//  AddMemoryViewPresenter.swift
//  FriendshipDiary
//
//  Created by Mateusz on 14/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

class AddMemoryViewPresenter {
    
    var friends: [ApiItemUser] = []
    
    var title: String?
    var description: String?
    var friendsToMemory: [String] = []
    var image: String?
    var latitude: Double?
    var longitude: Double?
    
    func configure(with draft: ApiItemMemory) {
        title = draft.title
        description = draft.description
        friendsToMemory = draft.friends ?? []
        image = draft.image
        latitude = draft.localization?.latitude
        longitude = draft.localization?.longitude
    }
    
    private func reset() {
        title = nil
        description = nil
        friendsToMemory.removeAll()
        image = nil
        latitude = nil
        longitude = nil
    }
    
    func getFriends(successBlock: @escaping ()->(), failtureBlock: @escaping (ApiItemError?) -> ()) {
        NetworkManager.getFriends(successBlock: { (dict) in
            guard let dict = dict else { return }
            guard let items = dict["items"] as? [[String:Any]] else { return }
            guard let data = try? JSONSerialization.data(withJSONObject: items, options: []) else { return }
            self.friends = (try? JSONDecoder().decode([ApiItemUser].self, from: data)) ?? []
            successBlock()
        }, failtureBlock: failtureBlock)
    }
    
    func addMemory(successBlock: @escaping ()->(), failtureBlock: @escaping (ApiItemError?) -> ()) {
        NetworkManager.postMemory(title: title ?? "", description: description ?? "", image: image ?? "", friends: friendsToMemory, latitude: latitude ?? 0, longitude: longitude ?? 0, successBlock: { (_) in
            self.reset()
            successBlock()
        }, failtureBlock: failtureBlock)
        
    }
    
    func addDraft(successBlock: @escaping ()->(), failtureBlock: @escaping (ApiItemError?) -> ()) {
        NetworkManager.postDraft(title: title ?? "", description: description ?? "", image: image ?? "", friends: friendsToMemory, latitude: latitude ?? 0, longitude: longitude ?? 0, successBlock: { (_) in
            self.reset()
            successBlock()
        }, failtureBlock: failtureBlock)
        
    }
    
}
