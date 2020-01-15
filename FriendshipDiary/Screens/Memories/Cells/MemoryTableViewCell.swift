//
//  MemoryTableViewCell.swift
//  FriendshipDiary
//
//  Created by Mateusz on 13/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MemoryTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var memoryImageView: UIImageView!
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with memory: ApiItemMemory) {
        titleLabel.text = memory.title
        descriptionLabel.text = memory.description
        if let friends = memory.friends, !friends.isEmpty {
            var labelText = "Przyjaciele: "
            for i in 0..<friends.count {
                labelText = labelText + friends[i] + (i == friends.count - 1 ? "" : ", ")
            }
            friendsLabel.text = labelText
            friendsLabel.isHidden = false
        } else {
            friendsLabel.isHidden = true
        }
        
        if let latitude = memory.localization?.latitude, let longitude = memory.localization?.longitude {
            let annotation = MKPointAnnotation()
            let memoryLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            annotation.coordinate = memoryLocation
            mapView.addAnnotation(annotation)
            mapView.showAnnotations([annotation], animated: true)

        }
        memoryImageView?.image = UIImage(base64: memory.image)
    }
    

}
