//
//  AppDelegate.swift
//  Buglife Example
//
//    Copyright 2017 Buglife.
//
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

import UIKit
import Buglife
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate, BuglifeDelegate, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Buglife.shared().start(withEmail: "Your_email_here") // Replace with your email to send bug reports
        Buglife.shared().invocationOptions = [.shake, .screenshot, .floatingButton]
        Buglife.shared().delegate = self
        Buglife.shared().inputFields = LIFETextInputField.bugDetailInputFields()
        
        let appearance = Buglife.shared().appearance
        appearance.barTintColor = .white
        appearance.tintColor = .purple
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor.rawValue: UIColor.black
        ]
      
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        let authStatus = CLLocationManager.authorizationStatus()
        if (authStatus == .notDetermined) {
            locationManager?.requestWhenInUseAuthorization()
        }
        return true
    }
    
    // MARK: BuglifeDelegate
    
    func buglife(_ buglife: Buglife, titleForPromptWithInvocation invocation: LIFEInvocationOptions) -> String? {
        return "Spotted a bug?"
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // do your usual location processing. 
    }
}

