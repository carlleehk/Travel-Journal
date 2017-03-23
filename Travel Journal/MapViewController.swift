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

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var searchLocation: UITextField!
    @IBOutlet weak var locationName: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    var firstRun = true
    var locValue: CLLocationCoordinate2D?
    var newPin = MKPointAnnotation()
    var data = [venue]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        map.delegate = self
        locationName.dataSource = self
        locationName.delegate = self
        searchLocation.delegate = self
        
        //setUserTracking()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        //set up keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
        
        /*if !firstRun{
            map.removeAnnotation(newPin)
        }*/
        
        locValue = (manager.location?.coordinate)!
        locationManager.stopUpdatingLocation()
        
        performUIUpdateOnMain {
            
            FourSquareClient.sharedInstance().getVenue(lat: self.locValue!.latitude, long: self.locValue!.longitude, searchString: nil){(success, error) in
                
                if (success != nil){
                    self.data = success!
                    self.locationName.reloadData()
                } else{
                    print("There is an error: \(error?.localizedDescription)")
                }
            }
        }
        
        updateMapPin(location: locValue!)
        /*let viewRegion = MKCoordinateRegionMakeWithDistance(locValue!, 1000, 1000)
        map.setRegion(viewRegion, animated: true)
        newPin.coordinate = locValue!
        map.addAnnotation(newPin)*/
        
        
        firstRun = false
        
        print("locations = \(locValue!.latitude) \(locValue!.longitude)")
    }
    
    func updateMapPin(location: CLLocationCoordinate2D){
        
        if !firstRun{
            map.removeAnnotation(newPin)
        }
        
        let viewRegion = MKCoordinateRegionMakeWithDistance(location, 1000, 1000)
        map.setRegion(viewRegion, animated: true)
        newPin.coordinate = location
        map.addAnnotation(newPin)
        
    }
    
    @IBAction func updateLocation(_ sender: Any) {
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

    }
    
    //TableView Set Up
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "location")!
        let name = data[indexPath.row]
        cell.textLabel?.text = name.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("there are \(data.count) datas")
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let info = data[indexPath.row]
        oneVenue.name = info.name
        oneVenue.location = info.location
        oneVenue.contact = info.contact
        oneVenue.url = info.url
        oneVenue.categories = info.categories
        let coordinate = CLLocationCoordinate2DMake(oneVenue.location?["lat"] as! CLLocationDegrees, oneVenue.location?["lng"] as! CLLocationDegrees)
        updateMapPin(location: coordinate)
        firstRun = false
        /*let lat = oneVenue.location?["lat"]
        let long = oneVenue.location?["lng"]
        print("\(lat), \(long)")*/

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let search = searchLocation.text
        performUIUpdateOnMain {
            
            FourSquareClient.sharedInstance().getVenue(lat: nil, long: nil, searchString: search){(success, error) in
                
                if (success != nil){
                    self.data = success!
                    self.locationName.reloadData()
                } else{
                    print("There is an error: \(error?.localizedDescription)")
                }
            }
        }
        return true
    }
    
   //Function to setup keyboard appear location
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
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
