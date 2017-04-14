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

class MapViewController: CoreDataViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var searchLocation: UITextField!
    @IBOutlet weak var locationName: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    var firstRun = true
    var locValue: CLLocationCoordinate2D?
    var newPin = MKPointAnnotation()
    var data = [venue]()
    var long: Double!
    var lat: Double!
    var localTimeZoneName: String {
        return TimeZone.current.identifier
    }
    
    var messageFrame = UIView()
    var strLabel = UILabel()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        nextButton.isEnabled = false
        
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locValue = (manager.location?.coordinate)!
        locationManager.stopUpdatingLocation()
            
        FourSquareClient.sharedInstance().getVenue(lat: self.locValue!.latitude, long: self.locValue!.longitude, searchString: nil){(success, error) in
                
            performUIUpdateOnMain {
                if (success != nil){
                    self.data = success!
                    self.locationName.reloadData()
                } else{
                    print("There is an error: \((error?.localizedDescription)!)")
                    let alertController = UIAlertController(title: "Error", message: "Network Request Error", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)

                }
                self.messageFrame.removeFromSuperview()
            }
        }
        
        updateMapPin(location: locValue!)
        
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
        
        nextButton.isEnabled = false
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            progressBarDisplay(msg: "Getting Location", indicator: true)
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
        
        
        JournalInfo.long = oneVenue.location?["lng"] as! Double
        JournalInfo.lat = oneVenue.location?["lat"] as! Double
        JournalInfo.locationName = info.name
        
        
        let coordinate = CLLocationCoordinate2DMake(JournalInfo.lat, JournalInfo.long)
        updateMapPin(location: coordinate)
        
        nextButton.isEnabled = true
        
        firstRun = false
  
    }
    
    @IBAction func next(_ sender: Any) {
        
        let date = Date()
        
        print(JournalInfo.locationName)
        let journalLocation = Location(lat: JournalInfo.lat, long: JournalInfo.long, name: JournalInfo.locationName, date: date, context: stack.context)
        journalLocation.name = JournalInfo.journalName
        print(journalLocation)
        save()
        JournalInfo.location = journalLocation
        let control = storyboard?.instantiateViewController(withIdentifier: "chooseScreen") as! ChooseScreenViewController
        present(control, animated: true, completion: nil)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nextButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let search = searchLocation.text
        textField.resignFirstResponder()
        progressBarDisplay(msg: "Getting Location", indicator: true)
        
        FourSquareClient.sharedInstance().getVenue(lat: nil, long: nil, searchString: search){(success, error) in
                
                performUIUpdateOnMain {
                    if (success != nil){
                        self.data = success!
                        self.locationName.reloadData()
                    } else{
                        
                        let alertController = UIAlertController(title: "Error", message: "Location not found, please retype another location for searching", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                        textField.text = ""
                        
                    }
                    self.messageFrame.removeFromSuperview()
            }
        }
                
        return true
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   //Function to setup keyboard appear location
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y += 100
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y -= 100
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func progressBarDisplay(msg: String, indicator: Bool){
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 240, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.white
        messageFrame = UIView(frame: CGRect(x: view.frame.midX  - 110, y: view.frame.midY - 25, width: 200, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
        
    }

}
