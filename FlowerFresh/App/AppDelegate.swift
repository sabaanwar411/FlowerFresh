//
//  AppDelegate.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 15/07/2025.
//

import UIKit
import FirebaseCore

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
            print("AppDelegate: App did finish launching")
            FirebaseApp.configure()
            return true
        }

        // Add other AppDelegate methods as needed
        func applicationWillResignActive(_ application: UIApplication) {
            // Handle app becoming inactive
        }
}

