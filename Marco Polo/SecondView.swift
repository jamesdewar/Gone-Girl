//
//  ViewController.swift
//  Marco Polo
//
//  Created by James Dewar on 21/03/15.
//  Copyright (c) 2015 IviData. All rights reserved.
//

import UIKit
import CoreLocation
import Darwin

class SecondView: UIViewController, UIApplicationDelegate, CLLocationManagerDelegate, OEEventsObserverDelegate {


    
    var lastProximity: CLProximity?
    var locationManager: CLLocationManager?
    var timer = NSTimer()
    var audioRecorder:AVAudioRecorder!
    var hue:CGFloat = 0.0
    var beacon_id_list : [Int] = [2310,1804,3006,1412]
    var clue_list : [String] = ["You have found the first clue. Next clue: In the smaller room you will find","You have found the Second clue. Next clue: In the smaller room you will find","You have found the Third clue. Next clue: In the smaller room you will find","You have found the Third clue. Next clue: In the smaller room you will find"]
    var major = 2310
    var index_beacon = 0
    var satDiv = CGFloat(0.0)
    var satDivResult = CGFloat(0.0)
    var sat = CGFloat(0.0)
 
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        if(locationManager!.respondsToSelector("requestAlwaysAuthorization")) {
            locationManager!.requestAlwaysAuthorization()
        }
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        beacon_region_to_monitor(beacon_id_list[0])
        
        
        
    }
    
    //Method to create a custom region, choose the Major/Minor that would suit you
    func beacon_region_to_monitor(major_input: Int)
    {
        let uuidString = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
        
        let minor = major_input
        let beaconIdentifier = "Estimote"
        let major_value:CLBeaconMajorValue = CLBeaconMajorValue(minor)
        let minor_value:CLBeaconMinorValue = CLBeaconMinorValue(minor)
        let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)!
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,major: major_value,minor: minor_value,identifier: beaconIdentifier)
        
        locationManager!.startMonitoringForRegion(beaconRegion)
        locationManager!.startRangingBeaconsInRegion(beaconRegion)
        locationManager!.startUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
}

extension SecondView: CLLocationManagerDelegate {
    

    
    func sendLocalNotificationWithMessage(message: String!, playSound: Bool) {
        let notification:UILocalNotification = UILocalNotification()
        notification.alertBody = message
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    
    func locationManager(manager: CLLocationManager!,didRangeBeacons beacons: [AnyObject]!,inRegion region: CLBeaconRegion!) {
        let beacon_rssi_int: String = ""
        
        NSLog("didRangeBeacons");
        
        
        var message:String = ""
        
        var playSound = false
        
        if(beacons.count > 0) {
            let nearestBeacon:CLBeacon = beacons[0] as CLBeacon
            
            var beacon_rssi_int: Int = nearestBeacon.rssi
            var beacon_rssi_string = String(beacon_rssi_int)
            var beacon_major_value = nearestBeacon.major
            var beacon_minor_value = nearestBeacon.minor
            var beacon_uuid = nearestBeacon.proximityUUID
        
            println(beacon_rssi_string)
            changeScreenColor(beacon_rssi_string)
            
            if (beacon_rssi_int > -40 && index_beacon < 4)
            {
                
                message = clue_list[index_beacon]
                sendLocalNotificationWithMessage(message, playSound: playSound)
                beacon_region_to_monitor(beacon_id_list[index_beacon])
                index_beacon++
            }
        }
    }
    
    func changeScreenColor(rssi: String)
    {
        var rssi_int = CGFloat(rssi.floatValue)
        rssi_int = -rssi_int
        
        if (rssi_int < 1)
        {
           
        }
        else
        {
            hue = rssi_int
        }
        var scale = ((hue - (50.0)) / 50.0 ) * 100 // change to 100 for full percentage
        var inverse = 100 - scale
        satDiv = (scale/200)
        satDivResult = ((scale/100) * satDiv)*1.2
        
        sat = (inverse/10) + 50
        
        
        self.view.backgroundColor = UIColor(hue: satDivResult, saturation: sat, brightness: 1.0, alpha: 1.0)
        //speech_to_rec.pocketsphinxDidReceiveHypothesis()
        
    }
    
}
extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}