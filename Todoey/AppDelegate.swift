//
//  AppDelegate.swift
//  Todoey
//
//  Created by Abdallah Ismail on 5/13/19.
//  Copyright © 2019 Abdallah Abdelrahman. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        do {
        _ = try Realm()
          
        }catch {

            print("Error initialising new realm, \(error)")
        }

        return true
    }

}
    




