//
//  ApiItemMemeory.swift
//  FriendshipDiary
//
//  Created by Mateusz on 06/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import SwiftyJSON

class ApiItemMemory: Decodable {
    var id: Int?
    var image: String?
    var title: String?
    var description: String?
    var friends: [String]?
    var localization: ApiItemLocalization?
    var uploaded: String?
}
