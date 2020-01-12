//
//  ViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 04/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkResponse {
    
    let jsonData: JSON!
    
    private init(jsonData: JSON?) {
        self.jsonData = jsonData ?? JSON()
    }
    
    class func SuccessResponse(jsonData:JSON) -> NetworkResponse {
        return NetworkResponse(jsonData: jsonData)
    }

    
}


