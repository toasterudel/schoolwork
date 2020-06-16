//
//  ViewController.swift
//  Maps
//
//  Created by Chris Rudel on 3/3/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//
// Second exercise for CS523 Assignment 4
// I pledge my honor that I have abided by the Stevens Honor System
// The first exercise can be found in the JSON folder

/* --- Coordinate info ----
 Stevens: 40.7442912, -74.0260221
 NYC: 40.7216294, -73.995453
 */

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    //below is the coordinate that the map is located around
    var coordinate2D = CLLocationCoordinate2DMake(40.7416064,-74.0303157)
    var isOn = false
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func standardBtn(_ sender: Any) {
        mapView.mapType = MKMapType.standard
    }
    @IBAction func satelliteBtn(_ sender: Any) {
        mapView.mapType = MKMapType.satellite
    }
    @IBAction func hybridBtn(_ sender: Any) {
        mapView.mapType = MKMapType.hybrid
    }
    
    @IBAction func toggleMapFeatures(_ sender: Any) {
        //This button will only work in camera mode, which i have not included
        //so i have disabled the button on the storyboard. The button is still visible on the
        //storyboard, but not in the app
        mapView.showsBuildings = isOn
        isOn = !isOn
    }
    @IBAction func zoomBtn(_ sender: Any) {
        var region = mapView.region
        region.span.latitudeDelta /= 2.0
        region.span.longitudeDelta /= 2.0
        mapView.setRegion(region, animated: true)
    }
    @IBAction func zoomOutBtn(_ sender: Any) {
        var region = mapView.region
        region.span.latitudeDelta *= 2.0
        region.span.longitudeDelta *= 2.0
        mapView.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPins()
        mapView.delegate = self
        updateMapRegion(rangeSpan: 850)
    }

    
    func updateMapRegion(rangeSpan: CLLocationDistance){
        let region = MKCoordinateRegion(center: coordinate2D, latitudinalMeters: rangeSpan, longitudinalMeters: rangeSpan)
        mapView.region = region
    }
    
    //Probably could've done this better in an array but I wasn't too sure on the syntax/how to do it
    func addPins(){
        let bennysPin = PinAnnotation(coordinate: CLLocationCoordinate2DMake(40.7441755,-74.028878), title: "Benny Tudino's", subtitle: "The Largest Slice in the State!")
        bennysPin.photo = UIImage(named:"bennys")
        let stevensParkPin = PinAnnotation(coordinate: CLLocationCoordinate2DMake(40.7416366,-74.0279232), title: "Stevens Park", subtitle: "Community park that offers a dog park and Little League games")
        stevensParkPin.photo = UIImage(named:"stevenspark")
        let carlosPin = PinAnnotation(coordinate: CLLocationCoordinate2DMake(40.7371844,-74.0309577), title: "Carlo's Bakery", subtitle: "Pastry store as seen on Cake Boss!")
        carlosPin.photo = UIImage(named:"carlos")
        let policePin = PinAnnotation(coordinate: CLLocationCoordinate2DMake(40.7376383,-74.0296719), title: "Hoboken Police Department", subtitle: "Police Department dedicated to keeping Hoboken safe")
        policePin.photo = UIImage(named:"police")
        let coffeePin = PinAnnotation(coordinate: CLLocationCoordinate2DMake(40.7413161,-74.0305869), title: "Empire Coffee & Tea Co.", subtitle: "Loved local coffee shop offering several different coffee and tea flavors")
        coffeePin.photo = UIImage(named:"empire")
        let biergartenPin = PinAnnotation(coordinate: CLLocationCoordinate2DMake(40.7523655,-74.0320189), title: "Pilsener Haus & Biergarten", subtitle: "Local pub where residents can gather and enjoy the food and drinks")
        biergartenPin.photo = UIImage(named:"biergarten")
        let pierPin = PinAnnotation(coordinate: CLLocationCoordinate2DMake(40.7369055,-74.0267185), title: "Pier A Park", subtitle: "Waterfront park great for playing catch and photography")
        pierPin.photo = UIImage(named:"pier")
        let ainsworthPin = PinAnnotation(coordinate: CLLocationCoordinate2DMake(40.7398033,-74.0269496), title: "Ainsworth", subtitle: "Local restaurant known for happy hour food and drinks")
        ainsworthPin.photo = UIImage(named:"ainsworth")
        let arthursPin = PinAnnotation(coordinate: CLLocationCoordinate2DMake(40.7398719,-74.0301467), title: "Arthurs", subtitle: "Restaurant renowned for their steak and burgers")
        arthursPin.photo = UIImage(named:"arthurs")
        let ayamePin = PinAnnotation(coordinate: CLLocationCoordinate2DMake(40.7430832,-74.0292185), title: "Ayame Hibachi & Sushi", subtitle: "Japanese restaurant including a sushi bar and hibachi shows")
        ayamePin.photo = UIImage(named:"ayame")
        let ottoPin = PinAnnotation(coordinate: CLLocationCoordinate2DMake(40.7464126,-74.0309904), title: "Otto Strada", subtitle: "Authentic Italian restaurant serving high quality food from a brick oven")
        ottoPin.photo = UIImage(named:"otto")
        
        mapView.addAnnotation(bennysPin)
        mapView.addAnnotation(stevensParkPin)
        mapView.addAnnotation(carlosPin)
        mapView.addAnnotation(policePin)
        mapView.addAnnotation(coffeePin)
        mapView.addAnnotation(biergartenPin)
        mapView.addAnnotation(pierPin)
        mapView.addAnnotation(ainsworthPin)
        mapView.addAnnotation(arthursPin)
        mapView.addAnnotation(ayamePin)
        mapView.addAnnotation(ottoPin)
    }
    
    //This is following the videos on lynda
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = MKPinAnnotationView()
        guard let annotation = annotation as? PinAnnotation
            else{
                return nil
        }
        if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier) as? MKPinAnnotationView{
            annotationView = dequedView
        } else{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
        }
        annotationView.pinTintColor = UIColor.blue
        annotationView.canShowCallout = true
        let paragraph = UILabel()
        paragraph.numberOfLines = 0
        paragraph.font = UIFont.preferredFont(forTextStyle: .caption1)
        paragraph.text = annotation.subtitle
        annotationView.detailCalloutAccessoryView = paragraph
        var photo = annotation.photo
        let size = CGSize(width: 50, height: 50)
        photo = resizeImage(image: photo!, scaledToSize: size)
        annotationView.leftCalloutAccessoryView = UIImageView(image: photo)
        
        return annotationView
    }
    
    //this function was taken from https://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
    //this function was essential to ensure the photos associated with each pin were not too big
    //we have not gone over CGSize in class and without it the photos were obstructing
    //the information of the pins
    func resizeImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

