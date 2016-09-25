//
//  ViewController.swift
//  PermissionExample_for_iOS8_n_iOS9Devices
//
//  Created by Burcu Geneci on 25/09/16.
//  Copyright © 2016 Burcu Geneci. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.askAndSetupLocation()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.askAndSetupLocation()
    }
    //MARK : Location Permission
    func askAndSetupLocation() -> Bool{
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        var accessGranted = false
        
        if authorizationStatus == .AuthorizedAlways ||
            authorizationStatus == .AuthorizedWhenInUse{
            self.setupLocationAndAskPermission(false)
            accessGranted = true
        }else if authorizationStatus == .NotDetermined {
            self.setupLocationAndAskPermission(true)
            accessGranted = false
        }else if authorizationStatus == .Denied
            || authorizationStatus == .Restricted{
            self.showLocationPermisionPopUp()
            accessGranted = false
        }
        return accessGranted
    }
    
    func setupLocationAndAskPermission(askPermission : Bool){
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if askPermission{
            self.locationManager.requestWhenInUseAuthorization()
        }
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
        
    }
    
    func showLocationPermisionPopUp(){
        
        weak var weakSelf = self
        let alert = UIAlertController.init(title: "We need your permission",
                                           message: "Your Permission Location Message",
                                           preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction.init(title: "Go to Settings",
                                          style: UIAlertActionStyle.Default) { (UIAlertAction) in
                                            weakSelf?.goToAppSettings()
        }
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func goToAppSettings(){
        if let settingsURL = NSURL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.sharedApplication().openURL(settingsURL)
        }
    }
}

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        let lat: Double = userLocation.coordinate.latitude
        let long: Double = userLocation.coordinate.longitude
        print("lat : \(lat), long \(long)")
        //Do whatever you want with your user's new location
    }
}

