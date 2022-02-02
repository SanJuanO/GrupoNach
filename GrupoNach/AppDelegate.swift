//
//  AppDelegate.swift
//  GrupoNach
//
//  Created by Oscar San juan on 01/02/22.
//


import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()


        return true
    }

    // MARK: - Core Data stack

  
}
