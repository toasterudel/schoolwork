//
//  ViewController.swift
//  RunningLate
//
//  Created by Chris Rudel on 2/25/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//
//  CS 523
//  Professor Damopolous
//  Running Late - Main.swift
//  I pledge my honor that I have abided by the Stevens Honor System - Christopher Rudel


import UIKit
import MapKit
import CoreLocation
import MessageUI

class Main: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {
    
    var HomeLocation: MKPointAnnotation?
    var AvailContacts: [Person]?
    var MessageToSend: String = "Hello, I am running late today I apologize for the inconvience!"
    var AlarmDays =
        [Weekday(day: "Sunday", enabled: false),
         Weekday(day: "Monday", enabled: true),
         Weekday(day: "Tuesday", enabled: true),
         Weekday(day: "Wednesday", enabled: true),
         Weekday(day: "Thursday", enabled: true),
         Weekday(day: "Friday", enabled: true),
         Weekday(day: "Saturday", enabled: false)]
    
    var AlarmTime:String = "9:00 AM"
    
    let defaults = UserDefaults.standard
    
    
    
    @IBAction func contactsBtn(_ sender: Any) {
        performSegue(withIdentifier: "contacts", sender: self)
    }
    
    @IBAction func messagesBtn(_ sender: Any) {
        performSegue(withIdentifier: "messages", sender: self)
    }
    @IBAction func calendarBtn(_ sender: Any) {
        performSegue(withIdentifier: "calendar", sender: self)
    }
    @IBOutlet weak var currentTimeLbl: UILabel!
    
    @IBAction func setHomeBtn(_ sender: Any) {
        if(HomeLocation == nil){
            let location = manager.location!
            HomeLocation = MKPointAnnotation()
            HomeLocation?.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            HomeLocation?.title = "Home"
            self.map.addAnnotation(HomeLocation!)
        }else{
            self.map.removeAnnotation(HomeLocation!)
            let location = manager.location!
            HomeLocation = MKPointAnnotation()
            HomeLocation?.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            HomeLocation?.title = "Home"
            self.map.addAnnotation(HomeLocation!)
        }
        
    }
    
    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0] //locations is a stack of the most recent user locations
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) //how zoomed in the map is
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation,span: span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* What the code below does is create a timer that checks every minute if
         the day is correct and if the time is correct. It takes this timer
         and adds it to the runloop so it constantly runs*/
        let checkLateTimer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(checkIfAlarm), userInfo: nil, repeats: true)
        RunLoop.main.add(checkLateTimer, forMode: .common)
        
        /* Originally I had this in viewDidAppear but I think it would add a timer to the runloop
           every time the view appeared which I didn't want.*/
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        print(AlarmTime)
        /* I have the below update in the timer but I also have it here because
           the timer checks every minute which doesnt check immediately*/
        let date = Date().description(with: .current)
        var strs = date.description.components(separatedBy: " ")
        var currentTime = strs[5]
        currentTime.removeLast(3)
        currentTime += " "
        currentTime += strs[6]
        currentTimeLbl.text = currentTime
        //print(AvailContacts ?? "no c")
        //print(MessageToSend)
    }
    @objc func checkIfAlarm(){
        print("30 seconds passed")
        let date = Date().description(with: .current)
        var strs = date.description.components(separatedBy: " ")
        var currentTime = strs[5]
        currentTime.removeLast(3)
        currentTime += " "
        currentTime += strs[6]
        currentTimeLbl.text = currentTime
        if(compareAlarmToDay()){
            print("Correct day")
            //print(currentTime)
            if(currentTime == AlarmTime){
                let location = manager.location!
                let currentLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                if(checkCurrLocationToHome(location: currentLocation)){
                    print("locations are the same")
                    let messageVC = MFMessageComposeViewController()
                    messageVC.body = MessageToSend
                    var phoneNumbers: [String] = []
                    for person in AvailContacts!{
                        if(person.selected){
                            phoneNumbers.append(person.phoneNumber)
                        }
                    }
                    if(!phoneNumbers.isEmpty){
                        print(phoneNumbers)
                        messageVC.recipients = phoneNumbers
                        messageVC.messageComposeDelegate = self
                        if(canSendText()){
                            self.present(messageVC, animated: true, completion: nil)
                            /*This is a bandaid to the problem that it will try to send
                              a message twice because the timer checks every 30 seconds*/
                            //sleep(60)
                        }
                    }
                }else{
                    print("locations are different")
                }
            }
        }
    }
    
    func checkCurrLocationToHome(location: CLLocationCoordinate2D) -> Bool{
        var retMe = false
        let currLat = String(location.latitude)
        let currLon = String(location.longitude)
        let homeLat:String = HomeLocation?.coordinate.latitude.description ?? ""
        let homeLon:String = HomeLocation?.coordinate.longitude.description ?? ""
        //print(currLat + " " + currLon)
        //print(homeLat + " " + homeLon)
        let goodCLat = currLat.prefix(7)
        let goodCLon = currLon.prefix(7)
        let goodHLat = homeLat.prefix(7)
        let goodHLon = homeLon.prefix(7)
        //print(goodCLat + " " + goodCLon)
        //print(goodHLat + " " + goodHLon)
        let currLatLast: Int = Int(String(goodCLat.last!)) ?? -1
        let currLonLast: Int = Int(String(goodCLon.last!)) ?? -1
        let homeLatLast: Int = Int(String(goodHLat.last!)) ?? -1
        let homeLonLast: Int = Int(String(goodHLon.last!)) ?? -1
        /*
        print("currlat currlon homelat homelon")
        print(currLatLast)
        print(currLonLast)
        print(homeLatLast)
        print(homeLonLast) */
        if(abs(currLatLast - homeLatLast) <= 3 && abs(currLonLast - homeLonLast) <= 3){
            retMe = true
        }
        
        return retMe
    }
    
    func canSendText() -> Bool{
        return MFMessageComposeViewController.canSendText()
    }
    func compareAlarmToDay() -> Bool{
        let date = Date().description(with: .current)
        //print(date)
        let currentDay = date.description.components(separatedBy: ",").first ?? ""
        var returnMe = false
        for days in AlarmDays{
            if(days.day == currentDay){
                returnMe = days.enabled
            }
        }
        return returnMe
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "messages"){
            let dest = segue.destination as! Messages
            dest.msg = MessageToSend
            if let contacts = AvailContacts{
                dest.AvailContacts = contacts
            }
        }
        if(segue.identifier == "contacts"){
            //print("transitioning to contacts")
            let dest = segue.destination as! Contacts
            if let contacts = AvailContacts{
                dest.AvailContacts = contacts
            }
        }
        
        if(segue.identifier == "calendar"){
            let dest = segue.destination as! Calendar
            dest.days = AlarmDays
            dest.timeOfAlarm = AlarmTime
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch(result){
        case .cancelled:
            print("The message was cancelled")
            dismiss(animated: true, completion: nil)
        case .failed:
            print("The message failed")
            dismiss(animated: true, completion: nil)
        case .sent:
            print("Hurray the message was sent")
            dismiss(animated: true, completion: nil)
            
        default:
            break
        
        }
    }
    
    //Below is more advanced running in background and persistance
    
    
    /* The function below is the function that is called before the app is shutdown
       I'm using it to save data */
    @objc func applicationWillResignActive(){
        print("closing time")
        let lat = HomeLocation?.coordinate.latitude.description
        let long = HomeLocation?.coordinate.longitude.description
        defaults.set(lat, forKey: "homeLat")
        defaults.set(long, forKey: "homeLong")
        /* I tried encoding the MKPointAnnotation of HomeLocation but it wouldn't let me
           but it does let me encode strings with no problems */
        defaults.set(try? PropertyListEncoder().encode(AvailContacts), forKey:"availableContacts")
        defaults.set(MessageToSend, forKey: "messageToSend")
        defaults.set(try? PropertyListEncoder().encode(AlarmDays), forKey: "alarmDays")
        defaults.set(AlarmTime, forKey: "alarmTime")
        defaults.synchronize()
    }
    
    /* The function below is the function that is called when the app is start from being
       closed. I'm using it to load data that was saved before it was quit*/
    @objc func applicationDidBecomeActive(){
        let lat = defaults.value(forKey: "homeLat") as? String ?? ""
        let long = defaults.value(forKey: "homeLong") as? String ?? ""
        //print(lat + " " + long)
        let latitude = (lat as NSString).doubleValue
        let longitude = (long as NSString).doubleValue
        let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        HomeLocation = MKPointAnnotation()
        HomeLocation?.coordinate = coord
        if(coord.latitude != 0.0 && coord.longitude != 0.0){
            HomeLocation?.title = "Home"
            self.map.addAnnotation(HomeLocation!) /* for some reason the map removes the pin on shutdown*/
        }
        if let contactData = defaults.value(forKey: "availableContacts") as? Data{
            AvailContacts = try? PropertyListDecoder().decode(Array<Person>.self, from: contactData)
        }
        MessageToSend = defaults.value(forKey: "messageToSend") as? String ?? ""
        if let daysData = defaults.value(forKey: "alarmDays") as? Data{
            AlarmDays = try! PropertyListDecoder().decode(Array<Weekday>.self, from: daysData)
        }
        AlarmTime = defaults.value(forKey: "alarmTime") as? String ?? "9:00 AM"
    }


}

