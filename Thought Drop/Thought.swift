//
//  ThoughtModel.swift
//  Thought Drop
//
//  Created by Oliver  on 2/17/17.
//  Copyright © 2017 Oliver . All rights reserved.
//

import MapKit

class Thought: NSObject, MKAnnotation {
    let title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
