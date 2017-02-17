//
//  ViewController.swift
//  Thought Drop
//
//  Created by Oliver  on 2/16/17.
//  Copyright © 2017 Oliver . All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ExploreController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var manager = CLLocationManager()
    
    var location: CLLocation?
    var latitude: CLLocationDegrees? { return location?.coordinate.latitude }
    var longitude: CLLocationDegrees? { return location?.coordinate.longitude }
    let latDelta: CLLocationDegrees = 0.05
    let lonDelta: CLLocationDegrees = 0.05
    
    static var thoughtText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

// MARK: - Location Manager
extension ExploreController {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        location = locations[0]
        guard let lat = latitude, let long = longitude else { return }
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(coordinates, span)
        map.setRegion(region, animated: false)
        
        if let text = ExploreController.thoughtText { drop(text) }
    }
}

// MARK: - Thought
extension ExploreController {
    func drop(_ text: String) {
        if let lat = latitude, let long = longitude {
            let thought = Thought(content: text, lat: lat, long: long)
            pin(thought)
            forgetThought()
        }
    }
    
    func pin(_ thought: Thought) {
        let pin = MKPointAnnotation()
        pin.coordinate.latitude = thought.lat
        pin.coordinate.longitude = thought.long
        pin.title = thought.content
        map.addAnnotation(pin)
    }
    
    func forgetThought() {
        ExploreController.thoughtText = nil
    }
}

