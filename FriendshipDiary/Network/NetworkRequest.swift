//
//  ViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 04/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import Alamofire

class NetworkRequest {
    
    private let dataRequest: DataRequest
    
    init(dataRequest: DataRequest) {
        self.dataRequest = dataRequest
    }
    
    func cancel() {
        dataRequest.cancel()
    }
    
}
