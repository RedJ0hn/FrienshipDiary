//
//  LoginViewPresenter.swift
//  FriendshipDiary
//
//  Created by Mateusz on 11/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

class LoginViewPresenter {
    var username: String?
    var password: String?
    
    func loginAction(successBlock: @escaping () -> (), failtureBlock: @escaping (ApiItemError?) -> ()) {
        NetworkManager.login(userName: username ?? "", password: password ?? "", successBlock: { (dict) in
            guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return }
            let token = try? JSONDecoder().decode(ApiItemToken.self, from: data)
            NetworkManager.sessionToken = token?.token ?? ""
            successBlock()
        }, failtureBlock: failtureBlock)
    }
}
