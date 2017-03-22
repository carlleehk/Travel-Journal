//
//  MapViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/22/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit

import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    var firstRun = true
    var locValue: CLLocationCoordinate2D?
    var newPin = MKPointAnnotation()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        map.delegate = self
        
        //setUserTracking()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func setUserTracking(){
     
     let trackingButton = MKUserTrackingBarButtonItem.init(mapView: map)
     trackingButton.customView?.sizeThatFits(CGSize(width: 50, height: 50))
     let originPoint = CGPoint(x: map.frame.width - 70, y: map.frame.height - 70)
     let roundSquare = UIView(frame: CGRect(origin: originPoint, size: CGSize(width: 50, height: 50)))
     //let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
     //toolbar.items = [flex, trackingButton, flex]
     map.addSubview(roundSquare)
     
     
     }*/
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !firstRun{
            map.removeAnnotation(newPin)
        }
        
        locValue = (manager.location?.coordinate)!
        locationManager.stopUpdatingLocation()
        
        FourSquareClient.sharedInstance().getVenue(lat: locValue!.latitude, long: locValue!.longitude){(success, error) in
            
            if (success != nil){
                print("something")
            } else{
                print("other thing")
            }
        }
        
        let viewRegion = MKCoordinateRegionMakeWithDistance(locValue!, 1000, 1000)
        map.setRegion(viewRegion, animated: true)
        newPin.coordinate = locValue!
        map.addAnnotation(newPin)
        
        firstRun = false
        
        print("locations = \(locValue!.latitude) \(locValue!.longitude)")
    }
    
    
    @IBAction func updateLocation(_ sender: Any) {
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}