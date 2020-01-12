//
//  RegisterViewPresenter.swift
//  FriendshipDiary
//
//  Created by Mateusz on 11/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

class RegisterViewPresenter {
    var username: String?
    var firstName: String?
    var lastName: String?
    var password: String?
    
    func registerAction(successBlock: @escaping () -> (), failtireBlock: @escaping (ApiItemError?) -> ()) {
        NetworkManager.register(userName: username ?? "" , password: password ?? "", firstName: firstName ?? "", lastName: lastName ?? "", successBlock: { (_) in
            successBlock()
        }, failtureBlock: failtireBlock)
        
    }
}
