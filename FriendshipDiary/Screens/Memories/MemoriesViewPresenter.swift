//
//  MemoriesViewPresenter.swift
//  FriendshipDiary
//
//  Created by Mateusz on 13/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

class MemoriesViewPresenter {
    var memories: [ApiItemMemory] = []
    
    func loadMemories(successBlock: @escaping ()->(), failtureBlock: @escaping (ApiItemError?) -> ()) {
        NetworkManager.getMemories(successBlock: { (dict) in
            guard let dict = dict else { return }
            guard let items = dict["items"] as? [[String:Any]] else { return }
            guard let data = try? JSONSerialization.data(withJSONObject: items, options: []) else { return }
            self.memories = (try? JSONDecoder().decode([ApiItemMemory].self, from: data)) ?? []
            successBlock()
            
        }, failtureBlock: failtureBlock)
    }
}
