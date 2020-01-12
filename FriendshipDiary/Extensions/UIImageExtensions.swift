//
//  UIImageExtensions.swift
//  FriendshipDiary
//
//  Created by Mateusz on 10/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init?(base64: String?) {
        guard let imageString = base64?.replacingOccurrences(of: #"^data:image/[a-z]+;base64,"#, with: "", options: .regularExpression) else { return nil }
        guard let data = Data(base64Encoded: imageString) else { return nil }
        self.init(data: data)
    }
    
    func imageToBase64() -> String? {
        let imageData:Data? =  self.pngData()
        let base64String = imageData?.base64EncodedString()
        return base64String
    }
    
}
