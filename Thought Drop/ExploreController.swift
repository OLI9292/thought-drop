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

    @IBOutlet weak var map: MKMapView! {
        didSet {
            map.delegate = self
        }
    }

    var manager = CLLocationManager()
    
    var location: CLLocation?
    var latitude: CLLocationDegrees? { return location?.coordinate.latitude }
    var longitude: CLLocationDegrees? { return location?.coordinate.longitude }
    var coordinate: CLLocationCoordinate2D? {
        guard let lat = location?.coordinate.latitude, let long = location?.coordinate.longitude else { return nil }
        return CLLocationCoordinate2DMake(lat, long)
    }
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
        
        if let coord = coordinate {
            let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(coord, span)
            
            map.setRegion(region, animated: false)
            
            if let text = ExploreController.thoughtText {
                drop(text)
            }
        }
    }
}


// MARK: - Annotation
extension ExploreController {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Thoughts"
        
        if annotation is Thought {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            } else {
                annotationView!.annotation = annotation
            }
            return annotationView
        }
        return nil
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let thought = view.annotation as! Thought
        let placeName = thought.title
        
        let ac = UIAlertController(title: placeName, message: placeName, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Pick Up", style: .default) { action in
            mapView.removeAnnotation(thought)
            // TODO: - add thought to ThoughtsController
        })
        ac.addAction(UIAlertAction(title: "Leave", style: .cancel))
        present(ac, animated: true)
    }
}


// MARK: - Thought
extension ExploreController {
    func drop(_ text: String) {
        if let coord = coordinate {
            let thought = Thought(title: text, coordinate: coord)
            map.addAnnotation(thought)
            forgetThought()
        }
    }
    
    func forgetThought() {
        ExploreController.thoughtText = nil
    }
}

