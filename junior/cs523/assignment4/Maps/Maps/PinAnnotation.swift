//
//  PinAnnotation.swift
//  Maps
//
//  Created by Chris Rudel on 3/4/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//

import UIKit
import MapKit

class PinAnnotation: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var identifier = "Pin"
    var photo:UIImage! = nil
    init(coordinate:CLLocationCoordinate2D, title:String?, subtitle:String?){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
