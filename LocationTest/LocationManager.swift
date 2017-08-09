//
//  LocationManager.swift
//  LocationTest
//
//  Created by bendnaiba on 8/8/17.
//  Copyright © 2017 bendnaiba. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate{

    let locationManager = CLLocationManager()

    func initLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.stopMonitoringSignificantLocationChanges()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let locValue:CLLocationCoordinate2D = locationObj.coordinate
        self.saveLocation(location: locValue)
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    public func saveLocation(location:CLLocationCoordinate2D) {
        let lat:NSNumber = NSNumber.init(value:location.latitude)
        let long:NSNumber = NSNumber.init(value:location.longitude)
        let dicoLocation:NSDictionary = NSDictionary.init(objects: [lat, long, Date.init()], forKeys: [NSString(string:"lat"), NSString(string:"long"), NSString(string:"Date")])
        if (UserDefaults.standard.array(forKey: "location") != nil) {
            let locationArray:NSMutableArray = NSMutableArray(array: UserDefaults.standard.array(forKey: "location")!)
            locationArray.add(dicoLocation)
            UserDefaults.standard.set(locationArray, forKey: "location")
        }
        else{
            let locationArray:NSMutableArray = NSMutableArray()
            locationArray.add(dicoLocation)
            UserDefaults.standard.set(locationArray, forKey: "location")
        }
        UserDefaults.standard.synchronize()
    }

}
